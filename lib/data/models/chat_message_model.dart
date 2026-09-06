class ChatMessageModel {
  final String id;
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;
  final String? transactionId;
  final double? transactionAmount;
  final String? transactionCurrency;
  final String? transactionStatus;
  final bool isTransaction;

  ChatMessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
    this.transactionId,
    this.transactionAmount,
    this.transactionCurrency,
    this.transactionStatus,
    this.isTransaction = false,
  });
}
