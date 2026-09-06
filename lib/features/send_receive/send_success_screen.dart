import 'package:flutter/material.dart';
import '../../data/models/user_model.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/utils/currency_formatter.dart';

class SendSuccessScreen extends StatelessWidget {
  const SendSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final String txId = data?['transactionId'] ?? 'ZAD-100855';
    final UserModel? recipient = data?['recipient'];
    final double amount = data?['amount'] ?? 1500.0;
    final String currency = data?['currency'] ?? 'EGP';
    final DateTime date = data?['date'] ?? DateTime.now();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Animated Success Checkmark Container
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check_circle_rounded,
                  size: 80,
                  color: AppColors.success,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                '✓ ${'transfer_successful'.tr(context)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppColors.success,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                CurrencyFormatter.format(amount, currency: currency),
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Sent to ${recipient?.name ?? "Mohamed Ali"}',
                style: TextStyle(
                  fontSize: 16,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),

              const SizedBox(height: 32),

              // Transaction Info Box
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : Colors.grey.shade100,
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
                        Text('transaction_id'.tr(context)),
                        Text(txId, style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Date & Time'),
                        Text(
                          CurrencyFormatter.formatDate(date),
                          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Action Buttons Row
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'done'.tr(context),
                      isOutlined: true,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomButton(
                      text: 'view_transaction'.tr(context),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/home',
                          (route) => false,
                        );
                        if (recipient != null) {
                          Navigator.pushNamed(
                            context,
                            '/chat',
                            arguments: {
                              'userId': recipient.id,
                              'userName': recipient.name,
                              'userAvatar': recipient.profileImage,
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
