// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:intl/intl.dart';

void main() {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse("1584415065000"));
  var time = DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime);
  print(time);
}
