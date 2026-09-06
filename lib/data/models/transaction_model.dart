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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'senderName': senderName,
      'receiverName': receiverName,
      'senderAvatar': senderAvatar,
      'receiverAvatar': receiverAvatar,
      'amount': amount,
      'currency': currency,
      'type': type.name,
      'status': status.name,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      senderName: json['senderName'] as String,
      receiverName: json['receiverName'] as String,
      senderAvatar: json['senderAvatar'] as String,
      receiverAvatar: json['receiverAvatar'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      type: TransactionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionType.sent,
      ),
      status: TransactionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatus.completed,
      ),
      date: DateTime.parse(json['date'] as String),
      note: json['note'] as String?,
    );
  }
}
