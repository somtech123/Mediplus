import 'package:intl/intl.dart';

final currencyFormat = NumberFormat("#,##0.00", "en_US");

class Utils {
  static String formatNumber(int number) {
    return NumberFormat.compact().format(number);
  }
}
