import '../models/chat_message_model.dart';

class MockChats {
  static final Map<String, List<ChatMessageModel>> _chats = {
    // Mohamed Ali (user_002)
    'user_002': [
      ChatMessageModel(
        id: 'msg_002_1',
        senderId: 'user_002',
        receiverId: 'user_001',
        message: 'يا أحمد عامل إيه؟',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 20)),
      ),
      ChatMessageModel(
        id: 'msg_002_2',
        senderId: 'user_001',
        receiverId: 'user_002',
        message: 'تمام الحمد لله ❤️',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 18)),
      ),
      ChatMessageModel(
        id: 'msg_002_3',
        senderId: 'user_002',
        receiverId: 'user_001',
        message: 'بعتلك الـ 750 جنيه بتوع العشا.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 12)),
      ),
      ChatMessageModel(
        id: 'msg_002_4',
        senderId: 'user_001',
        receiverId: 'user_002',
        message: 'Transfer Sent',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 10)),
        transactionId: 'ZAD-4B71P23X',
        transactionAmount: 750.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_002_5',
        senderId: 'user_001',
        receiverId: 'user_002',
        message: 'وصلوا، تسلم يا صاحبي.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 5)),
      ),
      ChatMessageModel(
        id: 'msg_002_6',
        senderId: 'user_002',
        receiverId: 'user_001',
        message: 'تمام 👌',
        timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 0)),
      ),
    ],

    // Omar Khaled (user_003)
    'user_003': [
      ChatMessageModel(
        id: 'msg_003_1',
        senderId: 'user_003',
        receiverId: 'user_001',
        message: 'محتاج تبعتلي الفلوس لما تفضى.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
      ),
      ChatMessageModel(
        id: 'msg_003_2',
        senderId: 'user_001',
        receiverId: 'user_003',
        message: 'حاضر، حولتهملك دلوقتي.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
      ChatMessageModel(
        id: 'msg_003_3',
        senderId: 'user_003',
        receiverId: 'user_001',
        message: 'Payment Received',
        timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
        transactionId: 'ZAD-8F42K91M',
        transactionAmount: 1500.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_003_4',
        senderId: 'user_003',
        receiverId: 'user_001',
        message: 'وصلتني ❤️',
        timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
      ),
      ChatMessageModel(
        id: 'msg_003_5',
        senderId: 'user_001',
        receiverId: 'user_003',
        message: 'تمام يا معلم 😂',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ),
    ],

    // Youssef Ahmed (user_004)
    'user_004': [
      ChatMessageModel(
        id: 'msg_004_1',
        senderId: 'user_004',
        receiverId: 'user_001',
        message: 'معلش حولتلك نص الإيجار.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3, minutes: 20)),
      ),
      ChatMessageModel(
        id: 'msg_004_2',
        senderId: 'user_004',
        receiverId: 'user_001',
        message: 'Rent Share Received',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
        transactionId: 'ZAD-5X83P19Z',
        transactionAmount: 2000.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_004_3',
        senderId: 'user_001',
        receiverId: 'user_004',
        message: 'تمام، وصل.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 40)),
      ),
      ChatMessageModel(
        id: 'msg_004_4',
        senderId: 'user_004',
        receiverId: 'user_001',
        message: 'كده الحساب خلص 😂',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2, minutes: 20)),
      ),
      ChatMessageModel(
        id: 'msg_004_5',
        senderId: 'user_001',
        receiverId: 'user_004',
        message: 'تمام يا باشا.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      ),
    ],

    // Sara Hassan (user_007)
    'user_007': [
      ChatMessageModel(
        id: 'msg_007_1',
        senderId: 'user_007',
        receiverId: 'user_001',
        message: 'أهلاً أحمد، بعتلك حساب الشوبنج.',
        timestamp: DateTime.now().subtract(const Duration(hours: 6, minutes: 30)),
      ),
      ChatMessageModel(
        id: 'msg_007_2',
        senderId: 'user_001',
        receiverId: 'user_007',
        message: 'تمام يا سارة، حولت الـ 320 جنيه.',
        timestamp: DateTime.now().subtract(const Duration(hours: 6, minutes: 15)),
        transactionId: 'ZAD-3M94K12V',
        transactionAmount: 320.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_007_3',
        senderId: 'user_007',
        receiverId: 'user_001',
        message: 'شكراً جداً 🌸',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ],

    // Mahmoud Adel (user_005)
    'user_005': [
      ChatMessageModel(
        id: 'msg_005_1',
        senderId: 'user_005',
        receiverId: 'user_001',
        message: 'أخبار الغداء إيه يا أحمد؟',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 7)),
      ),
      ChatMessageModel(
        id: 'msg_005_2',
        senderId: 'user_001',
        receiverId: 'user_005',
        message: 'حولتك الـ 1250 جنيه بتوع الغدا.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 6)),
        transactionId: 'ZAD-2R61V45M',
        transactionAmount: 1250.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_005_3',
        senderId: 'user_005',
        receiverId: 'user_001',
        message: 'تسلم يا حبيبنا 🍔',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      ),
    ],

    // Mostafa Mohamed (user_006)
    'user_006': [
      ChatMessageModel(
        id: 'msg_006_1',
        senderId: 'user_006',
        receiverId: 'user_001',
        message: 'مساء الخير يا أحمد، حولتلك الدفعة.',
        timestamp: DateTime.now().subtract(const Duration(hours: 9)),
      ),
      ChatMessageModel(
        id: 'msg_006_2',
        senderId: 'user_006',
        receiverId: 'user_001',
        message: 'Payment Sent',
        timestamp: DateTime.now().subtract(const Duration(hours: 8, minutes: 40)),
        transactionId: 'ZAD-7L29N84W',
        transactionAmount: 850.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_006_3',
        senderId: 'user_001',
        receiverId: 'user_006',
        message: 'وصلوا ألف شكر يا مصطفى.',
        timestamp: DateTime.now().subtract(const Duration(hours: 8, minutes: 20)),
      ),
    ],

    // Mariam Ahmed (user_008)
    'user_008': [
      ChatMessageModel(
        id: 'msg_008_1',
        senderId: 'user_001',
        receiverId: 'user_008',
        message: 'أهلاً مريم، بعتلك الهدية.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 9)),
        transactionId: 'ZAD-6K92B38T',
        transactionAmount: 450.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_008_2',
        senderId: 'user_008',
        receiverId: 'user_001',
        message: 'شكراً جداً يا أحمد ذوقك جميل ✨',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 8)),
      ),
    ],

    // Nour Khaled (user_009)
    'user_009': [
      ChatMessageModel(
        id: 'msg_009_1',
        senderId: 'user_009',
        receiverId: 'user_001',
        message: 'حولتك تحويل العيلة يا أحمد.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 12)),
        transactionId: 'ZAD-1P47H92D',
        transactionAmount: 3500.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_009_2',
        senderId: 'user_001',
        receiverId: 'user_009',
        message: 'وصلتني 3500 جنيه كاملة، تسلمي يا نور.',
        timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 11)),
      ),
    ],

    // Menna Ali (user_010)
    'user_010': [
      ChatMessageModel(
        id: 'msg_010_1',
        senderId: 'user_001',
        receiverId: 'user_010',
        message: 'بعتلك الـ 600 بتوع العشا.',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 4)),
        transactionId: 'ZAD-9T38C74K',
        transactionAmount: 600.00,
        transactionCurrency: 'EGP',
        transactionStatus: 'Completed',
        isTransaction: true,
      ),
      ChatMessageModel(
        id: 'msg_010_2',
        senderId: 'user_010',
        receiverId: 'user_001',
        message: 'وصلت شكراً لك 😊',
        timestamp: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      ),
    ],
  };

  static Map<String, List<ChatMessageModel>> getInitialChats() {
    final copy = <String, List<ChatMessageModel>>{};
    _chats.forEach((k, v) {
      copy[k] = List.from(v);
    });
    return copy;
  }

  static List<ChatMessageModel> getChatForUser(String userId) {
    if (_chats.containsKey(userId)) {
      return List.from(_chats[userId]!);
    }
    return [];
  }
}
