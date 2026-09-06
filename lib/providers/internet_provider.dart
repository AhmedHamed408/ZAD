import 'package:flutter/material.dart';
import '../data/models/internet_country_model.dart';
import '../data/models/internet_package_model.dart';
import '../data/mock/mock_internet_countries.dart';

class InternetProvider extends ChangeNotifier {
  List<InternetCountryModel> _allCountries = [];
  List<InternetPackageModel> _allPackages = [];
  String _selectedCountryId = 'eg';
  String _searchQuery = '';
  int? _selectedSizeFilter; // null = all, 10, 25, 50
  final List<String> _purchasedPackageIds = [];

  InternetProvider() {
    _allCountries = MockInternetCountries.countries;
    _allPackages = MockInternetCountries.getPackages();
  }

  List<InternetCountryModel> get allCountries => _allCountries;
  List<InternetPackageModel> get allPackages => _allPackages;
  String get selectedCountryId => _selectedCountryId;
  String get searchQuery => _searchQuery;
  int? get selectedSizeFilter => _selectedSizeFilter;
  List<String> get purchasedPackageIds => _purchasedPackageIds;

  InternetCountryModel get selectedCountryModel {
    return _allCountries.firstWhere(
      (c) => c.id == _selectedCountryId,
      orElse: () => _allCountries.first,
    );
  }

  // Backwards compatibility getter
  String get selectedCountry => selectedCountryModel.nameEn;

  // Backwards compatibility getter
  List<String> get countries => _allCountries.map((c) => c.nameEn).toList();

  // Backwards compatibility map
  Map<String, String> get countryFlags {
    final Map<String, String> map = {};
    for (final c in _allCountries) {
      map[c.nameEn] = c.flag;
    }
    return map;
  }

  List<InternetCountryModel> get filteredCountries {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return _allCountries;

    return _allCountries.where((c) {
      return c.nameEn.toLowerCase().contains(q) ||
          c.nameAr.toLowerCase().contains(q) ||
          c.nameFr.toLowerCase().contains(q) ||
          c.nameIt.toLowerCase().contains(q) ||
          c.isoCode.toLowerCase().contains(q);
    }).toList();
  }

  List<InternetPackageModel> get packagesForSelectedCountry {
    return _allPackages.where((pkg) {
      final matchesCountry = pkg.countryId == _selectedCountryId ||
          pkg.country.toLowerCase() == selectedCountryModel.nameEn.toLowerCase();
      final matchesSize = _selectedSizeFilter == null || pkg.dataGb == _selectedSizeFilter;
      return matchesCountry && matchesSize;
    }).toList();
  }

  void selectCountry(String countryIdOrName) {
    final match = _allCountries.firstWhere(
      (c) =>
          c.id == countryIdOrName.toLowerCase() ||
          c.nameEn.toLowerCase() == countryIdOrName.toLowerCase() ||
          c.nameAr.toLowerCase() == countryIdOrName.toLowerCase(),
      orElse: () => _allCountries.first,
    );
    _selectedCountryId = match.id;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSizeFilter(int? sizeGb) {
    _selectedSizeFilter = sizeGb;
    notifyListeners();
  }

  void purchasePackage(String packageId) {
    if (!_purchasedPackageIds.contains(packageId)) {
      _purchasedPackageIds.add(packageId);
      notifyListeners();
    }
  }

  bool isPackagePurchased(String packageId) {
    return _purchasedPackageIds.contains(packageId);
  }
}
