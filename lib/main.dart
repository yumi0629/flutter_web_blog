import 'package:flutter/material.dart';
import 'network/DioClient.dart';
import 'page/home.dart';
import 'package:oktoast/oktoast.dart';

void main() {
  DioClient.initConfig();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        title: '吉原拉面',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            tabBarTheme: TabBarTheme.of(context).copyWith(
              unselectedLabelColor: Colors.black87,
              labelColor: Colors.pink,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: UnderlineTabIndicator(
                  borderSide: const BorderSide(width: 4.0, color: Colors.pink)),
              labelStyle: TextStyle(fontSize: 20),
              unselectedLabelStyle: TextStyle(fontSize: 16),
            )),
        home: MyHomePage(title: 'Yumi\'s Note'),
        routes: {},
      ),
    );
  }
}
