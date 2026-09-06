import '../models/internet_package_model.dart';
import 'mock_internet_countries.dart';

class MockPackages {
  static List<InternetPackageModel> getPackages() {
    return MockInternetCountries.getPackages();
  }
}
