import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:yumi_note/network/api.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;
import 'package:yumi_note/util/route.dart';
import 'package:yumi_note/util/user_helper.dart';

class GithubLoginSuccessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GithubLoginSuccessState();
}

class _GithubLoginSuccessState extends State<GithubLoginSuccessPage> {
  String code;

  int authSuccess = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Uri uri = Uri.tryParse(js.context['location']['href']);
    code = uri.queryParameters['code'];
    _getUserInfo();
  }

  Widget _default() {
    return Material(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        child: SizedBox(
          width: 80,
          height: 40,
          child: FlareActor(
            "assets/loader.flr",
            animation: 'main',
          ),
        ),
      ),
    );
  }

  Widget _authSuccess() {
    return Material(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('images/login_success.png'),
            Container(
              height: 16,
            ),
            Text(
              '授权成功\n正在跳转至首页',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
            Container(
              height: 20,
            ),
            SizedBox(
              width: 80,
              height: 40,
              child: FlareActor(
                "assets/loader.flr",
                animation: 'main',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _authFail() {
    return Material(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('images/login_success.png'),
            Container(
              height: 16,
            ),
            Text(
              '授权失败\n请重试',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
            Container(
              height: 20,
            ),
            SizedBox(
              width: 80,
              height: 40,
              child: FlareActor(
                "assets/loader.flr",
                animation: 'main',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return authSuccess == 0
        ? _default()
        : authSuccess == 1 ? _authSuccess() : _authFail();
  }

  void _getUserInfo() {
    Dio()
      ..interceptors.add(InterceptorsWrapper(
        onError: (e) {
          debugPrint('Dio error with request: ${e.request.uri}');
          debugPrint('Request data: ${e.request.data}');
          debugPrint('Dio error: ${e.message}');
          authSuccess = -1;
          setState(() {});
          _goToHome();
          return e;
        },
      ))
      ..post('${Api.baseUrl}${Api.accessTokenUrl}',
          data: FormData.fromMap({
            'code': code,
          })).then((resp) {
        String accessToken = resp.data['access_token'];
        if (accessToken == null)
          authSuccess = -1;
        else
          authSuccess = 1;
        setState(() {});
        UserHelper.getGithubUserInfo(accessToken);
        _goToHome();
      });
  }

  void _goToHome() {
    debugPrint('_goToHome');
    Future.delayed(Duration(seconds: 3)).then((value) {
      debugPrint('pushNamedAndRemoveUntil');
      Navigator.of(context).pushNamedAndRemoveUntil(
          RouteName.initialRoute, ModalRoute.withName(RouteName.initialRoute));
    });
  }
}
