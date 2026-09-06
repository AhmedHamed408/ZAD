import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../../data/models/internet_package_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../providers/wallet_provider.dart';
import '../../../providers/transaction_provider.dart';
import '../../../providers/internet_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../localization/app_localizations.dart';

class ZadPurchaseSummaryDialog extends StatelessWidget {
  final InternetPackageModel package;

  const ZadPurchaseSummaryDialog({
    super.key,
    required this.package,
  });

  String _generateTxId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final rnd = Random();
    final code = List.generate(8, (_) => chars[rnd.nextInt(chars.length)]).join();
    return 'ZAD-INT-$code';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final walletProvider = Provider.of<WalletProvider>(context);

    // Current wallet balance
    final currentBalance = walletProvider.convertedBalance;
    final walletCurrency = walletProvider.selectedCurrencyCode;

    // Check if price in EGP equivalent or direct deduction
    final priceInEgp = package.currency == 'EGP' ? package.price : package.price;
    final balanceAfter = currentBalance - priceInEgp;
    final hasEnoughBalance = balanceAfter >= 0;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_rounded,
                    color: AppColors.accent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'confirm_purchase_title'.tr(context),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextPrimary
                              : AppColors.lightTextPrimary,
                        ),
                      ),
                      Text(
                        '${package.countryFlag} ${package.country}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Package Details Summary Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBackground : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        package.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(package.price,
                            currency: package.currency),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${package.data} • 30 ${'days'.tr(context)}',
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'demo_package_notice'.tr(context),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Wallet Balance Breakdown
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: isDark ? 0.2 : 0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'current_wallet_balance'.tr(context),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(currentBalance,
                            currency: walletCurrency),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'balance_after_purchase'.tr(context),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      Text(
                        CurrencyFormatter.format(
                            hasEnoughBalance ? balanceAfter : 0,
                            currency: walletCurrency),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: hasEnoughBalance
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (!hasEnoughBalance) ...[
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: AppColors.error, size: 16),
                  SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Your wallet balance is insufficient to make this purchase.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            const SizedBox(height: 24),

            // Actions: Cancel & Confirm
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: hasEnoughBalance
                        ? () {
                            // Execute purchase
                            final internetProvider =
                                Provider.of<InternetProvider>(context,
                                    listen: false);
                            final txProvider = Provider.of<TransactionProvider>(
                                context,
                                listen: false);
                            final authProvider = Provider.of<AuthProvider>(
                                context,
                                listen: false);

                            internetProvider.purchasePackage(package.id);
                            walletProvider.deductBalanceEGP(priceInEgp);

                            // Add to history
                            final currentUser = authProvider.currentUser!;
                            final txId = _generateTxId();
                            txProvider.addTransaction(
                              TransactionModel(
                                id: txId,
                                senderId: currentUser.id,
                                receiverId: 'zad_internet_${package.countryId}',
                                senderName: currentUser.name,
                                receiverName:
                                    'ZAD Internet (${package.country})',
                                senderAvatar: currentUser.profileImage,
                                receiverAvatar: package.countryFlag,
                                amount: package.price,
                                currency: package.currency,
                                type: TransactionType.package,
                                status: TransactionStatus.completed,
                                date: DateTime.now(),
                                note:
                                    'ZAD Internet - ${package.name} (${package.data})',
                              ),
                            );

                            Navigator.of(context).pop(true);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text('confirm_purchase'.tr(context)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
