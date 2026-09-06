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
  final String? transactionNote;
  final bool isTransaction;
  final bool isCall;
  final String? callType; // 'voice' | 'video'
  final String? callStatus; // 'completed' | 'cancelled' | 'missed'
  final int? callDurationSeconds;

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
    this.transactionNote,
    this.isTransaction = false,
    this.isCall = false,
    this.callType,
    this.callStatus,
    this.callDurationSeconds,
  });

  String get formattedCallDuration {
    if (callDurationSeconds == null || callDurationSeconds! <= 0) return '00:00';
    final minutes = (callDurationSeconds! / 60).floor().toString().padLeft(2, '0');
    final seconds = (callDurationSeconds! % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'transactionId': transactionId,
      'transactionAmount': transactionAmount,
      'transactionCurrency': transactionCurrency,
      'transactionStatus': transactionStatus,
      'transactionNote': transactionNote,
      'isTransaction': isTransaction,
      'isCall': isCall,
      'callType': callType,
      'callStatus': callStatus,
      'callDurationSeconds': callDurationSeconds,
    };
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      message: json['message'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      transactionId: json['transactionId'] as String?,
      transactionAmount: (json['transactionAmount'] as num?)?.toDouble(),
      transactionCurrency: json['transactionCurrency'] as String?,
      transactionStatus: json['transactionStatus'] as String?,
      transactionNote: json['transactionNote'] as String?,
      isTransaction: json['isTransaction'] as bool? ?? false,
      isCall: json['isCall'] as bool? ?? false,
      callType: json['callType'] as String?,
      callStatus: json['callStatus'] as String?,
      callDurationSeconds: json['callDurationSeconds'] as int?,
    );
  }
}
