import '../models/user_model.dart';
import '../models/transaction_model.dart';
import '../models/chat_message_model.dart';
import '../models/internet_package_model.dart';
import '../models/currency_model.dart';

import 'mock_users.dart';
import 'mock_transactions.dart';
import 'mock_chats.dart';
import 'mock_packages.dart';

export 'mock_users.dart';
export 'mock_transactions.dart';
export 'mock_chats.dart';
export 'mock_packages.dart';
export 'mock_locations.dart';

class MockData {
  static UserModel get currentUser => MockUsers.currentUser;
  static List<UserModel> get mockUsers => MockUsers.allUsers;

  static final List<CurrencyModel> currencies = [
    CurrencyModel(code: 'EGP', name: 'Egyptian Pound', symbol: 'EGP', flag: '🇪🇬', rateFromEGP: 1.0),
    CurrencyModel(code: 'SAR', name: 'Saudi Riyal', symbol: 'SAR', flag: '🇸🇦', rateFromEGP: 0.076),
    CurrencyModel(code: 'AED', name: 'UAE Dirham', symbol: 'AED', flag: '🇦🇪', rateFromEGP: 0.075),
    CurrencyModel(code: 'USD', name: 'US Dollar', symbol: '\$', flag: '🇺🇸', rateFromEGP: 0.020),
    CurrencyModel(code: 'EUR', name: 'Euro', symbol: '€', flag: '🇪🇺', rateFromEGP: 0.019),
  ];

  static List<TransactionModel> getInitialTransactions() {
    return MockTransactions.getInitialTransactions();
  }

  static List<InternetPackageModel> getPackages() {
    return MockPackages.getPackages();
  }

  static List<ChatMessageModel> getMockMessages(String otherUserId) {
    return MockChats.getChatForUser(otherUserId);
  }
}
