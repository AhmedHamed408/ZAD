import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../data/mock/mock_users.dart';
import '../../../data/models/chat_message_model.dart';
import '../../../localization/app_localizations.dart';
import 'zad_call_details_sheet.dart';

class ZadChatCallCard extends StatelessWidget {
  final ChatMessageModel message;
  final String otherUserName;
  final String currentUserId;

  const ZadChatCallCard({
    super.key,
    required this.message,
    required this.otherUserName,
    this.currentUserId = 'user_001',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMe = message.senderId == currentUserId;
    final isVoice = message.callType == 'voice';
    final isCompleted = message.callStatus == 'completed';

    final titleText = isVoice ? 'voice_call'.tr(context) : 'video_call'.tr(context);
    final headerIcon = isVoice ? '📞' : '🎥';
    final accentColor = isVoice ? AppColors.accent : Colors.purple;

    final user = MockUsers.allUsers.firstWhere(
      (u) => u.id == (isMe ? message.receiverId : message.senderId),
      orElse: () => MockUsers.currentUser,
    );

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: accentColor.withValues(alpha: isDark ? 0.4 : 0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: accentColor.withValues(alpha: isDark ? 0.2 : 0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            onTap: () => ZadCallDetailsSheet.show(
              context: context,
              message: message,
              user: user,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Accent Header Strip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  color: accentColor.withValues(alpha: isDark ? 0.25 : 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(headerIcon, style: const TextStyle(fontSize: 15)),
                          const SizedBox(width: 6),
                          Text(
                            titleText,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : accentColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: (isCompleted ? AppColors.success : Colors.red)
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          isCompleted ? 'completed'.tr(context) : 'cancelled'.tr(context),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isCompleted ? AppColors.success : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Call Card Content
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isCompleted ? message.formattedCallDuration : 'cancelled'.tr(context),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            CurrencyFormatter.formatShortDate(message.timestamp),
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: accentColor,
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
