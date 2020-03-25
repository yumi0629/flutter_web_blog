import 'package:intl/intl.dart';

class DateHelper {
  static String formatTime(String time) {
    DateTime dateTime = DateFormat('yyyy-MM-ddThh:mm:ss.zzzZ')
        .parse('2019-07-29T03:17:45.589Z');
    return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  }
}
