class InternetPackageModel {
  final String id;
  final String countryId;
  final String country;
  final String countryFlag;
  final String name;
  final String data;
  final int dataGb;
  final int minutes;
  final int validityDays;
  final double price;
  final String currency;
  final String currencySymbol;
  final int sms;
  final String? badge; // 'best_value', 'popular', null
  final List<String> features;
  final bool isDemo;

  const InternetPackageModel({
    required this.id,
    this.countryId = 'eg',
    required this.country,
    required this.countryFlag,
    required this.name,
    required this.data,
    this.dataGb = 10,
    this.minutes = 0,
    this.validityDays = 30,
    required this.price,
    required this.currency,
    this.currencySymbol = '',
    this.sms = 0,
    this.badge,
    required this.features,
    this.isDemo = true,
  });
}
