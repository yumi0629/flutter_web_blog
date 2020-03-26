// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:yumi_note/network/Api.dart';

class GithubLoginDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GithubLoginState();
}

class _GithubLoginState extends State<GithubLoginDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'SIGN IN',
            style: TextStyle(fontSize: 20),
          ),
          Container(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              _loginWithGithub();
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/github.png',
                    width: 16,
                    height: 16,
                  ),
                  Container(
                    width: 16,
                  ),
                  Text(
                    'Login with Github',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 40,
          ),
          Row(
            children: <Widget>[
              Text('New to Github?'),
              GestureDetector(
                onTap: () {
                  js.context.callMethod('open', ['https://github.com']);
                },
                child: Text(
                  'Create an account',
                  style: TextStyle(color: Colors.pinkAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _loginWithGithub() {
    String url =
        '${Api.githubAuthorizeUrl}client_id=${Api.clientId}&redirect_uri=${Api.redirectUri}';
    html.document.window.location.href = url;
  }
}
