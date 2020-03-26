import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:yumi_note/model/github_user.dart';
import 'package:yumi_note/page/article_detail_page.dart';
import 'package:yumi_note/page/right_page.dart';
import 'package:yumi_note/util/route.dart';
import 'package:yumi_note/util/user_helper.dart';
import 'package:yumi_note/widget/no_transition_page_route.dart';

import 'article_list_page.dart';
import 'about_me.dart';
import 'github_login_dialog.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Tab> _tabs = [
    Tab(
      text: '文章',
    ),
    Tab(
      text: '生活',
    ),
    Tab(
      text: '关于我',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            _buildTop(),
            Expanded(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: LayoutBuilder(builder: (_, constraints) {
                      double margin = constraints.maxWidth * 0.1;
                      return Padding(
                        padding: EdgeInsets.fromLTRB(margin, 20, margin, 20),
                        child: _buildTabViews(),
                      );
                    }),
                    flex: 2,
                  ),
                  Flexible(
                    child: RightPage(),
                    flex: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 60, right: 60),
      constraints: BoxConstraints(maxHeight: 70),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildLogo(),
            flex: 1,
          ),
          Expanded(
            child: _buildTabs(),
            flex: 1,
          ),
          Expanded(
            child: _SignInPage(),
            flex: 2,
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Color(0x1F000000),
          blurRadius: 2,
          spreadRadius: 2,
        ),
      ]),
    );
  }

  Widget _buildTabs() {
    return TabBar(
      tabs: _tabs,
      controller: _tabController,
    );
  }

  Widget _buildTabViews() {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildTabViewArticle(),
        _buildTabViewLife(),
        _buildTabViewAboutMe(),
      ],
      controller: _tabController,
    );
  }

  Widget _buildTabViewLife() {
    return WillPopScope(
        child: Navigator(
          initialRoute: RouteName.myLife,
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case RouteName.initialRoute:
                builder = (_) => Container();
                break;
              case RouteName.myLife:
                builder = (_) => Container();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
                break;
            }
            return NoTransitionPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
        onWillPop: () {
          print('WillPopScope _buildTabViewLife');
          return Future.value(false);
        });
  }

  Widget _buildTabViewAboutMe() {
    return WillPopScope(
        child: Navigator(
          initialRoute: RouteName.aboutMe,
          onGenerateRoute: (settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case RouteName.initialRoute:
                builder = (_) => AboutMePage();
                break;
              case RouteName.aboutMe:
                builder = (_) => AboutMePage();
                break;
              default:
                throw Exception('Invalid route: ${settings.name}');
                break;
            }
            return NoTransitionPageRoute(
              builder: builder,
              settings: settings,
            );
          },
        ),
        onWillPop: () {
          print('WillPopScope _buildTabViewAboutMe');
          return Future.value(false);
        });
  }

  Widget _buildTabViewArticle() {
    return WillPopScope(
      child: Navigator(
        key: ArticleNavHelper.articleNavKey,
        initialRoute: RouteName.articleList,
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case RouteName.initialRoute:
              builder = (_) => ArticleListPage();
              break;
            case RouteName.articleList:
              builder = (_) => ArticleListPage();
              break;
            case RouteName.articleDetail:
              builder = (_) => ArticleDetailPage();
              break;
            default:
              throw Exception('Invalid route: ${settings.name}');
              break;
          }
          return NoTransitionPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
      onWillPop: () {
        print('WillPopScope _buildTabViewArticle');
        ArticleNavHelper.popUntil(ModalRoute.withName(RouteName.articleList));
        return Future.value(false);
      },
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'images/yumi_header.png',
          width: 40,
          height: 40,
        ),
        Container(
          width: 10,
        ),
        Image.asset(
          'images/yumi_logo.png',
          width: 120,
          height: 40,
        ),
      ],
    );
  }
}

class _SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State {
  GithubUser user;

  @override
  void initState() {
    super.initState();
    UserHelper.readUserFromSP().then((value) {
      if (value != null) {
        UserHelper.getGithubUserInfo(user.accessToken).then((resp) {
          user = resp;
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) return _buildSignIn();
    return _buildLogOut();
  }

  Widget _buildLogOut() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            SharedPreferencesPlugin()
                .remove('user')
                .then((value) => setState(() {}));
          },
          child: Container(
            width: 120,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  user.avatarUrl ?? 'images/github.png',
                  width: 22,
                  height: 22,
                ),
                Container(
                  width: 16,
                ),
                Text(
                  'Log Out',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                child: AlertDialog(
                  content: GithubLoginDialog(),
                ));
          },
          child: Container(
            width: 120,
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
                  'Login In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
