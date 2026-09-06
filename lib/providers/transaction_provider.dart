import 'package:flutter/material.dart';
import '../data/models/transaction_model.dart';
import '../data/models/chat_message_model.dart';
import '../data/mock/mock_data.dart';

class TransactionProvider extends ChangeNotifier {
  List<TransactionModel> _transactions = [];
  final Map<String, List<ChatMessageModel>> _chatMessages = {};

  List<TransactionModel> get transactions => _transactions;

  List<TransactionModel> get recentTransactions => _transactions.take(5).toList();

  TransactionProvider() {
    _transactions = MockData.getInitialTransactions();
  }

  List<TransactionModel> getTodayTransactions() {
    return _transactions.where((t) => t.isToday()).toList();
  }

  List<TransactionModel> getYesterdayTransactions() {
    return _transactions.where((t) => t.isYesterday()).toList();
  }

  List<TransactionModel> getEarlierTransactions() {
    return _transactions.where((t) => !t.isToday() && !t.isYesterday()).toList();
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  List<ChatMessageModel> getChatMessages(String otherUserId) {
    if (!_chatMessages.containsKey(otherUserId)) {
      _chatMessages[otherUserId] = MockData.getMockMessages(otherUserId);
    }
    return _chatMessages[otherUserId]!;
  }

  void sendChatMessage(String otherUserId, String text) {
    final messages = getChatMessages(otherUserId);
    messages.add(
      ChatMessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        senderId: 'user_0',
        receiverId: otherUserId,
        message: text,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
