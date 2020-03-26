import 'package:dio/dio.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:yumi_note/model/github_user.dart';
import 'package:yumi_note/network/Api.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:yumi_note/util/route.dart';

class GithubLoginSuccessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GithubLoginSuccessState();
}

class _GithubLoginSuccessState extends State<GithubLoginSuccessPage> {
  String code;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Uri uri = Uri.tryParse(js.context['location']['href']);
    code = uri.queryParameters['code'];
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('images/login_success.png'),
            Container(height: 16,),
            Text(
              '授权成功\n正在跳转至首页',
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 2,
                color: Colors.black54,
                fontSize: 25,
              ),
            ),
            Container(height: 20,),
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

  void _getUserInfo() {
    String accessTokenUrl =
        '${Api.accessTokenUrl}client_id=${Api.clientId}&client_secret=${Api.clientSecret}&code=$code';

    Dio().get(accessTokenUrl).then((resp) {
      String accessToken = resp.data['access_token'];
      Dio().get(Api.getGithubUserInfo, queryParameters: {
        'access_token': accessToken,
      }).then((resp) {
        GithubUser user = GithubUser();
        user.accessToken = resp.data['accessToken'];
        user.login = resp.data['login'];
        user.id = resp.data['id'];
        user.name = resp.data['name'];
        user.avatarUrl = resp.data['avatarUrl'];
        SharedPreferencesPlugin().setValue('String', 'user', user);
        Future.delayed(Duration(seconds: 3)).then((value) {
          Navigator.of(context).pushNamedAndRemoveUntil(RouteName.initialRoute,
              ModalRoute.withName(RouteName.initialRoute));
        });
      });
    });
  }
}
