import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/transaction_model.dart';
import '../data/models/chat_message_model.dart';
import '../data/mock/mock_data.dart';

class TransactionProvider extends ChangeNotifier {
  static const String _kChatMessagesKey = 'zad_chat_messages_v2';
  static const String _kActiveConvsKey = 'zad_active_conversations_v2';
  static const String _kTransactionsKey = 'zad_transactions_v2';

  List<TransactionModel> _transactions = [];
  final Map<String, List<ChatMessageModel>> _chatMessages = {};
  final Set<String> _activeConversations = {};

  List<TransactionModel> get transactions => _transactions;
  List<TransactionModel> get recentTransactions => _transactions.take(5).toList();

  TransactionProvider() {
    _initPersistence();
  }

  Future<void> _initPersistence() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. Load Transactions
      final txString = prefs.getString(_kTransactionsKey);
      if (txString != null && txString.isNotEmpty) {
        final List<dynamic> jsonList = jsonDecode(txString);
        _transactions = jsonList.map((j) => TransactionModel.fromJson(j)).toList();
      } else {
        _transactions = MockData.getInitialTransactions();
      }

      // 2. Load Chat Messages
      final chatString = prefs.getString(_kChatMessagesKey);
      if (chatString != null && chatString.isNotEmpty) {
        final Map<String, dynamic> jsonMap = jsonDecode(chatString);
        jsonMap.forEach((key, val) {
          final List<dynamic> list = val;
          _chatMessages[key] = list.map((j) => ChatMessageModel.fromJson(j)).toList();
        });
      } else {
        final initialMockChats = MockChats.getInitialChats();
        initialMockChats.forEach((key, list) {
          _chatMessages[key] = list;
        });
      }

      // 3. Load Active Conversations
      final convsList = prefs.getStringList(_kActiveConvsKey);
      if (convsList != null && convsList.isNotEmpty) {
        _activeConversations.addAll(convsList);
      } else {
        // Default initial active conversations are all mock chats that have messages
        _chatMessages.forEach((userId, msgs) {
          if (msgs.isNotEmpty) {
            _activeConversations.add(userId);
          }
        });
      }
    } catch (e) {
      debugPrint('Error loading TransactionProvider persistence: $e');
      _transactions = MockData.getInitialTransactions();
      final initialMockChats = MockChats.getInitialChats();
      initialMockChats.forEach((key, list) {
        _chatMessages[key] = list;
        if (list.isNotEmpty) _activeConversations.add(key);
      });
    }

    notifyListeners();
  }

  Future<void> _savePersistence() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 1. Save Transactions
      final txJsonStr = jsonEncode(_transactions.map((t) => t.toJson()).toList());
      await prefs.setString(_kTransactionsKey, txJsonStr);

      // 2. Save Chat Messages
      final Map<String, dynamic> chatMap = {};
      _chatMessages.forEach((k, v) {
        chatMap[k] = v.map((m) => m.toJson()).toList();
      });
      await prefs.setString(_kChatMessagesKey, jsonEncode(chatMap));

      // 3. Save Active Conversations
      await prefs.setStringList(_kActiveConvsKey, _activeConversations.toList());
    } catch (e) {
      debugPrint('Error saving TransactionProvider persistence: $e');
    }
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

  TransactionModel? getTransactionById(String id) {
    try {
      return _transactions.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Open or create a conversation with [otherUserId].
  /// If conversation doesn't exist, initializes an empty message list for [otherUserId].
  void openOrCreateConversation(String otherUserId) {
    if (!_chatMessages.containsKey(otherUserId)) {
      _chatMessages[otherUserId] = List.from(MockChats.getChatForUser(otherUserId));
    }
    _activeConversations.add(otherUserId);
    _savePersistence();
    notifyListeners();
  }

  /// Returns user IDs of all active conversations, sorted by latest activity timestamp.
  List<String> getActiveConversationUserIds() {
    final List<String> activeIds = [];

    for (final id in _activeConversations) {
      activeIds.add(id);
    }

    // Also include any user that has messages or transactions
    for (final entry in _chatMessages.entries) {
      if (entry.value.isNotEmpty && !activeIds.contains(entry.key)) {
        activeIds.add(entry.key);
      }
    }

    // Sort by latest message/transaction timestamp
    activeIds.sort((a, b) {
      final msgsA = getChatMessages(a);
      final msgsB = getChatMessages(b);

      final timeA = msgsA.isNotEmpty
          ? msgsA.last.timestamp
          : DateTime.fromMillisecondsSinceEpoch(0);
      final timeB = msgsB.isNotEmpty
          ? msgsB.last.timestamp
          : DateTime.fromMillisecondsSinceEpoch(0);

      return timeB.compareTo(timeA);
    });

    return activeIds;
  }

  List<ChatMessageModel> getChatMessages(String otherUserId) {
    if (!_chatMessages.containsKey(otherUserId)) {
      _chatMessages[otherUserId] = List.from(MockChats.getChatForUser(otherUserId));
    }

    final currentMessages = _chatMessages[otherUserId]!;

    // Synchronize transactions between current user ('user_001') and otherUserId into chat timeline
    final matchingTx = _transactions.where((t) =>
        (t.senderId == 'user_001' && t.receiverId == otherUserId) ||
        (t.senderId == otherUserId && t.receiverId == 'user_001') ||
        (t.receiverId == 'user_002' && otherUserId == 'user_002'));

    for (final tx in matchingTx) {
      final exists = currentMessages.any((m) => m.transactionId == tx.id);
      if (!exists) {
        currentMessages.add(
          ChatMessageModel(
            id: 'msg_tx_${tx.id}',
            senderId: tx.senderId,
            receiverId: tx.receiverId,
            message: tx.note ?? (tx.senderId == 'user_001' ? 'Money Sent' : 'Money Received'),
            timestamp: tx.date,
            transactionId: tx.id,
            transactionAmount: tx.amount,
            transactionCurrency: tx.currency,
            transactionStatus: tx.status == TransactionStatus.completed
                ? 'Completed'
                : (tx.status == TransactionStatus.pending ? 'Pending' : 'Failed'),
            transactionNote: tx.note,
            isTransaction: true,
          ),
        );
      }
    }

    // Sort chronologically by timestamp
    currentMessages.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return currentMessages;
  }

  void sendChatMessage(String otherUserId, String text) {
    final messages = getChatMessages(otherUserId);
    messages.add(
      ChatMessageModel(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        senderId: 'user_001',
        receiverId: otherUserId,
        message: text,
        timestamp: DateTime.now(),
      ),
    );
    _activeConversations.add(otherUserId);
    _savePersistence();
    notifyListeners();
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);

    // If transaction is between current user and a chat contact, update chat list
    final otherUserId = transaction.senderId == 'user_001'
        ? transaction.receiverId
        : transaction.senderId;

    _activeConversations.add(otherUserId);

    if (_chatMessages.containsKey(otherUserId)) {
      final messages = _chatMessages[otherUserId]!;
      final exists = messages.any((m) => m.transactionId == transaction.id);
      if (!exists) {
        messages.add(
          ChatMessageModel(
            id: 'msg_tx_${transaction.id}',
            senderId: transaction.senderId,
            receiverId: transaction.receiverId,
            message: transaction.note ?? (transaction.senderId == 'user_001' ? 'Money Sent' : 'Money Received'),
            timestamp: transaction.date,
            transactionId: transaction.id,
            transactionAmount: transaction.amount,
            transactionCurrency: transaction.currency,
            transactionStatus: transaction.status == TransactionStatus.completed
                ? 'Completed'
                : (transaction.status == TransactionStatus.pending ? 'Pending' : 'Failed'),
            transactionNote: transaction.note,
            isTransaction: true,
          ),
        );
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }
    } else {
      _chatMessages[otherUserId] = [];
      getChatMessages(otherUserId); // Triggers transaction syncing
    }

    _savePersistence();
    notifyListeners();
  }

  void addCallLogMessage({
    required String otherUserId,
    required String callType,
    required String callStatus,
    required int durationSeconds,
  }) {
    final messages = getChatMessages(otherUserId);
    messages.add(
      ChatMessageModel(
        id: 'msg_call_${DateTime.now().millisecondsSinceEpoch}',
        senderId: 'user_001',
        receiverId: otherUserId,
        message: callType == 'voice' ? 'Voice Call' : 'Video Call',
        timestamp: DateTime.now(),
        isCall: true,
        callType: callType,
        callStatus: callStatus,
        callDurationSeconds: durationSeconds,
      ),
    );
    _activeConversations.add(otherUserId);
    _savePersistence();
    notifyListeners();
  }
}
