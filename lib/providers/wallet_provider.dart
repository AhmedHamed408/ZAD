import 'package:flutter/material.dart';
import '../data/models/currency_model.dart';
import '../data/mock/mock_data.dart';

class WalletProvider extends ChangeNotifier {
  double _baseBalanceEGP = 25450.00;
  String _selectedCurrencyCode = 'EGP';

  double get baseBalanceEGP => _baseBalanceEGP;
  double get balance => _baseBalanceEGP;
  String get selectedCurrencyCode => _selectedCurrencyCode;

  List<CurrencyModel> get currencies => MockData.currencies;

  CurrencyModel get selectedCurrency {
    return currencies.firstWhere(
      (c) => c.code == _selectedCurrencyCode,
      orElse: () => currencies.first,
    );
  }

  double get convertedBalance {
    return _baseBalanceEGP * selectedCurrency.rateFromEGP;
  }

  void selectCurrency(String code) {
    if (ArabCurrencies.isSupportedCurrency(code)) {
      _selectedCurrencyCode = code;
      notifyListeners();
    }
  }

  void deductBalanceEGP(double amountInEGP) {
    _baseBalanceEGP -= amountInEGP;
    if (_baseBalanceEGP < 0) _baseBalanceEGP = 0;
    notifyListeners();
  }

  void deductBalance(double amount) => deductBalanceEGP(amount);

  void addBalanceEGP(double amountInEGP) {
    _baseBalanceEGP += amountInEGP;
    notifyListeners();
  }
}
