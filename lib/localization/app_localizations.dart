import 'package:flutter/material.dart';
import 'ar.dart';
import 'en.dart';
import 'fr.dart';
import 'it.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': enTranslations,
    'ar': arTranslations,
    'fr': frTranslations,
    'it': itTranslations,
  };

  String translate(String key) {
    final languageCode = locale.languageCode;
    if (_localizedValues.containsKey(languageCode) &&
        _localizedValues[languageCode]!.containsKey(key)) {
      return _localizedValues[languageCode]![key]!;
    }
    return _localizedValues['en']?[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'fr', 'it'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

extension TranslateString on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context).translate(this);
  }
}
