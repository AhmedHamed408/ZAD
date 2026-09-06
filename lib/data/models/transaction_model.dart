enum TransactionType { sent, received, package }

enum TransactionStatus { completed, pending, failed }

class TransactionModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String senderName;
  final String receiverName;
  final String senderAvatar;
  final String receiverAvatar;
  final double amount;
  final String currency;
  final TransactionType type;
  final TransactionStatus status;
  final DateTime date;
  final String? note;

  TransactionModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.senderAvatar,
    required this.receiverAvatar,
    required this.amount,
    required this.currency,
    required this.type,
    required this.status,
    required this.date,
    this.note,
  });

  bool isToday() {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day;
  }
}
