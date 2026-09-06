import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../data/models/transaction_model.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../localization/app_localizations.dart';

class ZadTransactionDetailsSheet extends StatelessWidget {
  final TransactionModel transaction;

  const ZadTransactionDetailsSheet({
    super.key,
    required this.transaction,
  });

  static void show(BuildContext context, TransactionModel transaction) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ZadTransactionDetailsSheet(transaction: transaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tx = transaction;
    final isReceived = tx.type == TransactionType.received;
    final isPackage = tx.type == TransactionType.package;

    final partyName = isPackage
        ? tx.receiverName
        : (isReceived ? tx.senderName : tx.receiverName);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.all(24.0),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Handle
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Header Icon & Amount
            Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isPackage
                          ? Colors.blue.withValues(alpha: 0.15)
                          : (isReceived
                              ? AppColors.success.withValues(alpha: 0.15)
                              : AppColors.primary.withValues(alpha: 0.15)),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      isPackage ? '📶' : (isReceived ? '💰' : '💸'),
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${isReceived ? '+' : '-'}${CurrencyFormatter.format(tx.amount, currency: tx.currency)}',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: isReceived
                          ? AppColors.success
                          : (isDark ? Colors.white : AppColors.lightTextPrimary),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isPackage
                        ? tx.receiverName
                        : (isReceived
                            ? '${'from_person'.tr(context)} $partyName'
                            : '${'to_person'.tr(context)} $partyName'),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  if (tx.note != null && tx.note!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkBackground : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '📝 ${tx.note}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Rows Overview
            _buildDetailRow(
              context,
              label: 'transaction_id'.tr(context),
              value: tx.id,
              isMonospace: true,
              canCopy: true,
            ),
            _buildDetailRow(
              context,
              label: 'Status',
              value: tx.status == TransactionStatus.completed
                  ? 'tx_completed'.tr(context)
                  : (tx.status == TransactionStatus.pending
                      ? 'tx_pending'.tr(context)
                      : 'tx_failed'.tr(context)),
              isBadge: true,
            ),
            _buildDetailRow(
              context,
              label: 'Date & Time',
              value: CurrencyFormatter.formatDate(tx.date),
            ),
            _buildDetailRow(
              context,
              label: isReceived ? 'from_person'.tr(context) : 'to_person'.tr(context),
              value: partyName,
            ),

            const SizedBox(height: 24),

            // Close Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'done'.tr(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context, {
    required String label,
    required String value,
    bool isBadge = false,
    bool isMonospace = false,
    bool canCopy = false,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          if (isBadge)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '✓ $value',
                style: const TextStyle(
                  color: AppColors.success,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            )
          else
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: isMonospace ? 'monospace' : null,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                if (canCopy) ...[
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: value));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Transaction ID copied!'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.copy_rounded,
                      size: 16,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
