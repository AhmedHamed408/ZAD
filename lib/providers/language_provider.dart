import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('ar'); // Default to Arabic as requested for Egyptian fintech ZAD

  Locale get locale => _locale;

  LanguageProvider() {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString('language_code') ?? 'ar';
    _locale = Locale(langCode);
    notifyListeners();
  }

  Future<void> setLanguage(String languageCode) async {
    if (!['en', 'ar', 'fr', 'it'].contains(languageCode)) return;
    _locale = Locale(languageCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', languageCode);
    notifyListeners();
  }

  bool get isRTL => _locale.languageCode == 'ar';
  bool get isArabic => _locale.languageCode == 'ar';
  Locale get currentLocale => _locale;
}
