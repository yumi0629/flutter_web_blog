import 'package:intl/intl.dart';

extension Format on String {
  String format() {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse("${this}000"));
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }

  String formatToDay() {
    DateTime dateTime = DateFormat('yyyy-MM-ddThh:mm:ssZ').parse(this);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
