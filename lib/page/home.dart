import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences_web/shared_preferences_web.dart';
import 'package:yumi_note/model/github_user.dart';
import 'package:yumi_note/page/article_detail_page.dart';
import 'package:yumi_note/page/life_detail_page.dart';
import 'package:yumi_note/page/my_life_page.dart';
import 'package:yumi_note/page/right_page.dart';
import 'package:yumi_note/util/app_info.dart';
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

  final List<Tab> _tabsVertical = [
    Tab(
      text: '文章',
    ),
    Tab(
      text: '生活',
    ),
    Tab(
      text: '关于我',
    ),
    Tab(
      text: 'Events',
    ),
  ];

  Size size;

  bool get isVertical => size.width < size.height;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build _tabController = $_tabController");
    size = size ?? MediaQuery.of(context).size;
    _tabController = _tabController ??
        (isVertical
            ? TabController(length: _tabsVertical.length, vsync: this)
            : TabController(length: _tabs.length, vsync: this));

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            isVertical ? _buildTopVertical() : _buildTop(),
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
                  isVertical
                      ? Container(width: 0)
                      : Flexible(
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

  Widget _buildTopVertical() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 30, right: 30),
      constraints: BoxConstraints(maxHeight: 70),
      child: Row(
        children: <Widget>[
          _buildLogo(),
          Expanded(
            child: _buildTabs(),
          ),
          LayoutBuilder(builder: (ctx, constraints) {
            return GestureDetector(
              onTap: () {
                final RenderBox button = ctx.findRenderObject();
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject();
                final RelativeRect position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(button.size.bottomLeft(Offset.zero),
                        ancestor: overlay),
                    button.localToGlobal(button.size.bottomRight(Offset.zero),
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );
                showMenu(
                    context: context,
                    position: position,
                    items: [PopupMenuItem(child: _SignInPage())]);
              },
              child: Icon(
                Icons.more_horiz,
                color: Colors.black87,
              ),
            );
          }),
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
      tabs: isVertical ? _tabsVertical : _tabs,
      controller: _tabController,
    );
  }

  Widget _buildTabViews() {
    List<Widget> widgets = [
      _buildTabViewArticle(),
      _buildTabViewLife(),
      _buildTabViewAboutMe(),
    ];
    if (isVertical) widgets.add(RightPage());
    return WillPopScope(
      onWillPop: () {
        switch (_tabController.index) {
          case 0: // 文章
            ArticleNavHelper.popUntil(
                ModalRoute.withName(RouteName.articleList));
            break;
          case 1: // 生活
            LifeNavHelper.popUntil(ModalRoute.withName(RouteName.myLife));
            break;
        }
        return Future.value(false);
      },
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: widgets,
        controller: _tabController,
      ),
    );
  }

  Widget _buildTabViewArticle() {
    return Navigator(
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
    );
  }

  Widget _buildTabViewLife() {
    return Navigator(
      key: LifeNavHelper.lifeNavKey,
      initialRoute: RouteName.myLife,
      onGenerateRoute: (settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case RouteName.initialRoute:
            builder = (_) => MyLifePage();
            break;
          case RouteName.myLife:
            builder = (_) => MyLifePage();
            break;
          case RouteName.lifeDetail:
            builder = (_) => LifeDetailPage();
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
    );
  }

  Widget _buildTabViewAboutMe() {
    return Navigator(
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
        isVertical
            ? Container(width: 0)
            : Container(
                width: 10,
              ),
        isVertical
            ? Container(width: 0)
            : Image.asset(
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
    debugPrint('_SignInPage initState');
    UserHelper.readUserFromSP().then((value) {
      if (value != null) {
        debugPrint('value.name = ${value.name}');
        UserHelper.getGithubUserInfo(value.accessToken).then((_) {
          user = AppInfo.getInstance().user;
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
            width: 140,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  user.avatarUrl,
                  width: 28,
                  height: 28,
                  errorBuilder: (_, __, ___) {
                    return Image.asset(
                      'images/github.png',
                      width: 22,
                      height: 22,
                    );
                  },
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
