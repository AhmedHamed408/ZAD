class CurrencyModel {
  final String countryCode;
  final String countryNameEn;
  final String countryNameAr;
  final String countryNameFr;
  final String countryNameIt;
  final String currencyCode;
  final String currencyNameEn;
  final String currencyNameAr;
  final String currencyNameFr;
  final String currencyNameIt;
  final String currencySymbol;
  final String flagEmoji;
  final double rateFromEGP;

  const CurrencyModel({
    required this.countryCode,
    required this.countryNameEn,
    required this.countryNameAr,
    required this.countryNameFr,
    required this.countryNameIt,
    required this.currencyCode,
    required this.currencyNameEn,
    required this.currencyNameAr,
    required this.currencyNameFr,
    required this.currencyNameIt,
    required this.currencySymbol,
    required this.flagEmoji,
    required this.rateFromEGP,
  });

  // Backwards compatibility getters
  String get code => currencyCode;
  String get name => currencyNameEn;
  String get symbol => currencySymbol;
  String get flag => flagEmoji;

  String getLocalizedCountryName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return countryNameAr;
      case 'fr':
        return countryNameFr;
      case 'it':
        return countryNameIt;
      case 'en':
      default:
        return countryNameEn;
    }
  }

  String getLocalizedCurrencyName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return currencyNameAr;
      case 'fr':
        return currencyNameFr;
      case 'it':
        return currencyNameIt;
      case 'en':
      default:
        return currencyNameEn;
    }
  }
}

class ArabCurrencies {
  static const Set<String> supportedCurrencyCodes = {
    'EGP',
    'SAR',
    'AED',
    'KWD',
    'QAR',
    'BHD',
    'OMR',
    'JOD',
    'IQD',
    'LBP',
    'SYP',
    'ILS',
    'YER',
    'MAD',
    'DZD',
    'TND',
    'LYD',
    'SDG',
    'MRU',
    'SOS',
    'DJF',
    'KMF',
  };

  static bool isSupportedCurrency(String code) {
    return supportedCurrencyCodes.contains(code.toUpperCase());
  }
}
