import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:yumi_note/page/github_events_page.dart';

class RightPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RightState();
}

class _RightState extends State<RightPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        double margin = constraints.maxWidth * 0.2;
        return Container(
          margin: EdgeInsets.fromLTRB(0, 40, margin, 40),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              _CardPage(width: constraints.maxWidth),
              Padding(padding: EdgeInsets.all(16), child: GithubEventsPage()),
            ],
          ),
        );
      },
    );
  }
}

class _CardPage extends StatefulWidget {
  final double width;

  const _CardPage({Key key, @required this.width}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CardState();
}

class _CardState extends State<_CardPage> with TickerProviderStateMixin {
  final appContainer =
      html.document.getElementsByTagName('body')[0] as html.Element;

  AnimationController controller;

  final TextStyle textStyle = TextStyle(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w100,
    decoration: TextDecoration.underline,
    decorationColor: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reset();
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      width: widget.width * 0.5,
      height: widget.width * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg_info.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: LayoutBuilder(builder: (_, constraints) {
        double size = constraints.maxWidth / 5.0 * 2.0;
        return Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: size * 0.05),
              child: Center(
                child: MouseRegion(
                  child: RotationTransition(
                    turns: controller,
                    child: Image.asset(
                      'images/header.png',
                      width: size,
                      height: size * 0.48,
                    ),
                  ),
                  onEnter: (_) {
                    controller.forward();
                  },
                  onExit: (_) {
                    controller
                        .forward(from: controller.value)
                        .then((value) => controller.reset());
                  },
                ),
              ),
              width: size,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/introduction.png',
                    height: 25,
                  ),
                  Container(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'images/qq.png',
                        width: 16,
                        height: 16,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(
                        '984542616',
                        style: textStyle,
                      ),
                    ],
                  ),
                  Container(
                    height: 16,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        'images/github.png',
                        width: 16,
                        height: 16,
                      ),
                      Container(
                        width: 10,
                      ),
                      GestureDetector(
                        child: MouseRegion(
                          child: Text(
                            'https://github.com/yumi0629',
                            style: textStyle,
                          ),
                          onHover: (_) => appContainer.style.cursor = 'pointer',
                          onExit: (_) => appContainer.style.cursor = 'default',
                        ),
                        onTap: () {
                          print('open');
                          js.context.callMethod(
                              'open', ['https://github.com/yumi0629']);
                        },
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
