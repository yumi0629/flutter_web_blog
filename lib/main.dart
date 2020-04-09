import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yumi_note/page/github_login_success_page.dart';
import 'package:yumi_note/util/route.dart';
import 'network/dio_client.dart';
import 'page/home.dart';

void main() {
  DioClient.initConfig();
  configLoading();
  runApp(MyApp());
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.pink
    ..backgroundColor = Colors.blue
    ..indicatorColor = Colors.pink
    ..textColor = Colors.pink
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
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
        routes: {
          RouteName.githubAuthSuccess: (_) => GithubLoginSuccessPage(),
        },
      ),
    );
  }
}
