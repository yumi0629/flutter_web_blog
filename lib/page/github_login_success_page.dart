import 'package:flutter/material.dart';

class GithubLoginSuccessPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GithubLoginSuccessState();
}

class _GithubLoginSuccessState extends State<GithubLoginSuccessPage> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('授权成功，正在跳转至首页......'),
        ],
      ),
    );
  }
}
