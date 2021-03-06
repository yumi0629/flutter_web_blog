import 'package:flutter/material.dart';

class RouteName {
  static const String initialRoute = '/';
  static const String articleList = '/article_list';
  static const String articleDetail = '/article_detail';
  static const String aboutMe = '/about_me';
  static const String myLife = '/my_life';
  static const String lifeDetail = '/life_detail';
  static const String githubAuthSuccess = '/github_login';
}

class ArticleNavHelper {
  static GlobalKey<NavigatorState> articleNavKey = GlobalKey();

  static void popUntil(RoutePredicate predicate) {
    articleNavKey.currentState.popUntil(predicate);
  }

  static Future<T> pushNamed<T extends Object>(
    String routeName, {
    Object arguments,
  }) {
    return articleNavKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }
}

class LifeNavHelper {
  static GlobalKey<NavigatorState> lifeNavKey = GlobalKey();

  static void popUntil(RoutePredicate predicate) {
    lifeNavKey.currentState.popUntil(predicate);
  }

  static Future<T> pushNamed<T extends Object>(
      String routeName, {
        Object arguments,
      }) {
    return lifeNavKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }
}
