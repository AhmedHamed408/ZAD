import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../data/models/user_model.dart';
import '../../data/models/transaction_model.dart';
import '../../providers/auth_provider.dart';
import '../../providers/wallet_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/utils/currency_formatter.dart';

class SendReviewScreen extends StatelessWidget {
  const SendReviewScreen({super.key});

  String _generateTxId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random();
    final code = List.generate(8, (_) => chars[rnd.nextInt(chars.length)]).join();
    return 'ZAD-$code';
  }

  void _handleConfirmTransfer(BuildContext context, Map<String, dynamic> data) async {
    final UserModel recipient = data['recipient'];
    final double amount = data['amount'];
    final String currency = data['currency'];
    final String note = data['note'];

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);
    final txProvider = Provider.of<TransactionProvider>(context, listen: false);

    final currentUser = authProvider.currentUser!;
    final String txId = _generateTxId();
    final DateTime now = DateTime.now();

    // 1. Deduct balance locally
    walletProvider.deductBalanceEGP(amount);

    // 2. Add transaction to history
    final newTx = TransactionModel(
      id: txId,
      senderId: currentUser.id,
      receiverId: recipient.id,
      senderName: currentUser.name,
      receiverName: recipient.name,
      senderAvatar: currentUser.profileImage,
      receiverAvatar: recipient.profileImage,
      amount: amount,
      currency: currency,
      type: TransactionType.sent,
      status: TransactionStatus.completed,
      date: now,
      note: note.isNotEmpty ? note : 'Money transfer',
    );
    txProvider.addTransaction(newTx);

    // 3. Navigate to Success screen with details
    Navigator.pushReplacementNamed(
      context,
      '/send-success',
      arguments: {
        'transactionId': txId,
        'recipient': recipient,
        'amount': amount,
        'currency': currency,
        'date': now,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (data == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Review data not found')),
      );
    }

    final UserModel recipient = data['recipient'];
    final double amount = data['amount'];
    final String currency = data['currency'];
    final String note = data['note'];

    return Scaffold(
      appBar: AppBar(
        title: Text('review_transfer'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Summary Card
              Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(recipient.profileImage),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        recipient.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        recipient.phone,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),

                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),

                      _buildSummaryRow(
                        context,
                        label: 'amount'.tr(context),
                        value: CurrencyFormatter.format(amount, currency: currency),
                      ),
                      const SizedBox(height: 12),

                      _buildSummaryRow(
                        context,
                        label: 'transfer_fee'.tr(context),
                        value: '0 EGP (FREE)',
                        valueColor: AppColors.success,
                      ),
                      const SizedBox(height: 12),

                      if (note.isNotEmpty) ...[
                        _buildSummaryRow(
                          context,
                          label: 'note'.tr(context),
                          value: note,
                        ),
                        const SizedBox(height: 12),
                      ],

                      const Divider(),
                      const SizedBox(height: 16),

                      _buildSummaryRow(
                        context,
                        label: 'total_amount'.tr(context),
                        value: CurrencyFormatter.format(amount, currency: currency),
                        isBold: true,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),

              CustomButton(
                text: 'confirm_transfer'.tr(context),
                icon: Icons.check_circle_rounded,
                onPressed: () => _handleConfirmTransfer(context, data),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 18 : 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: valueColor ??
                (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
          ),
        ),
      ],
    );
  }
}
