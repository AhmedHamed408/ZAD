class CurrencyModel {
  final String code;
  final String name;
  final String symbol;
  final String flag;
  final double rateFromEGP; // Conversion multiplier relative to EGP

  CurrencyModel({
    required this.code,
    required this.name,
    required this.symbol,
    required this.flag,
    required this.rateFromEGP,
  });
}
