import 'package:flutter/material.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../data/models/transaction_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/zad_transaction_details_sheet.dart';
import '../../../localization/app_localizations.dart';

class ZadChatTransactionCard extends StatelessWidget {
  final ChatMessageModel message;
  final String otherUserName;
  final String currentUserId;
  final TransactionModel? transaction;

  const ZadChatTransactionCard({
    super.key,
    required this.message,
    required this.otherUserName,
    this.currentUserId = 'user_001',
    this.transaction,
  });

  void _openDetails(BuildContext context) {
    if (transaction != null) {
      ZadTransactionDetailsSheet.show(context, transaction!);
    } else {
      // Fallback TransactionModel if matching instance not passed directly
      final fallbackTx = TransactionModel(
        id: message.transactionId ?? 'ZAD-DEMO-TX',
        senderId: message.senderId,
        receiverId: message.receiverId,
        senderName: message.senderId == currentUserId ? 'Ahmed Hassan' : otherUserName,
        receiverName: message.senderId == currentUserId ? otherUserName : 'Ahmed Hassan',
        senderAvatar: 'https://i.pravatar.cc/300?img=11',
        receiverAvatar: 'https://i.pravatar.cc/300?img=12',
        amount: message.transactionAmount ?? 0.0,
        currency: message.transactionCurrency ?? 'EGP',
        type: message.senderId == currentUserId
            ? TransactionType.sent
            : TransactionType.received,
        status: TransactionStatus.completed,
        date: message.timestamp,
        note: message.transactionNote ?? message.message,
      );
      ZadTransactionDetailsSheet.show(context, fallbackTx);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isSentByMe = message.senderId == currentUserId;
    final amount = message.transactionAmount ?? 0.0;
    final currency = message.transactionCurrency ?? 'EGP';
    final txId = message.transactionId ?? 'ZAD-8F42K91M';
    final note = message.transactionNote ?? (message.message.isNotEmpty ? message.message : 'Transfer');

    final titleText = isSentByMe
        ? 'money_sent'.tr(context)
        : 'money_received'.tr(context);

    final personLabel = isSentByMe
        ? '${'to_person'.tr(context)} $otherUserName'
        : '${'from_person'.tr(context)} $otherUserName';

    final headerIcon = isSentByMe ? '💸' : '💰';
    final accentColor = isSentByMe ? AppColors.primary : AppColors.success;

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSentByMe
                ? AppColors.primary.withValues(alpha: 0.4)
                : AppColors.success.withValues(alpha: 0.4),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (isSentByMe ? AppColors.primary : AppColors.success)
                  .withValues(alpha: isDark ? 0.25 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Accent Strip
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: isSentByMe
                    ? AppColors.primary.withValues(alpha: isDark ? 0.3 : 0.1)
                    : AppColors.success.withValues(alpha: isDark ? 0.3 : 0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(headerIcon, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 6),
                        Text(
                          titleText,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isSentByMe
                                ? (isDark ? Colors.white : AppColors.primary)
                                : AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              size: 12, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text(
                            'tx_completed'.tr(context),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.success,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Card Main Body
              InkWell(
                onTap: () => _openDetails(context),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount & Currency
                      Text(
                        '${isSentByMe ? '-' : '+'}${CurrencyFormatter.format(amount, currency: currency)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: isSentByMe
                              ? (isDark ? Colors.white : AppColors.lightTextPrimary)
                              : AppColors.success,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Person Name (To / From)
                      Text(
                        personLabel,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Note / Reason Badge
                      if (note.isNotEmpty && note != 'Money transfer')
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkBackground
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '🍽️ $note',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),
                      const Divider(height: 1),
                      const SizedBox(height: 10),

                      // Footer: TX ID & Date & "View Details"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                txId,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                              Text(
                                CurrencyFormatter.formatShortDate(message.timestamp),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),

                          TextButton.icon(
                            onPressed: () => _openDetails(context),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 12,
                              color: accentColor,
                            ),
                            label: Text(
                              'view_details'.tr(context),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
