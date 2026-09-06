import 'package:intl/intl.dart';

class CurrencyFormatter {
  static String format(double amount, {String currency = 'EGP'}) {
    final formatter = NumberFormat('#,##0.00', 'en_US');
    return '${formatter.format(amount)} $currency';
  }

  static String formatDate(DateTime date) {
    final formatter = DateFormat('MMM dd, yyyy • hh:mm a');
    return formatter.format(date);
  }

  static String formatShortDate(DateTime date) {
    final formatter = DateFormat('hh:mm a');
    return formatter.format(date);
  }
}
