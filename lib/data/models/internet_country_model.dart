class InternetCountryModel {
  final String id;
  final String nameEn;
  final String nameAr;
  final String nameFr;
  final String nameIt;
  final String isoCode;
  final String flag;
  final String currencyCode;
  final String currencySymbol;

  const InternetCountryModel({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.nameFr,
    required this.nameIt,
    required this.isoCode,
    required this.flag,
    required this.currencyCode,
    required this.currencySymbol,
  });

  String getLocalizedName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ar':
        return nameAr;
      case 'fr':
        return nameFr;
      case 'it':
        return nameIt;
      case 'en':
      default:
        return nameEn;
    }
  }
}
