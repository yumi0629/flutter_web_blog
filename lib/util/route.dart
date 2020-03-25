import 'package:flutter/material.dart';

class RouteName {
  static const String initialRoute = '/';
  static const String articleList = '/article_list';
  static const String articleDetail = '/article_detail';
  static const String aboutMe = '/about_me';
  static const String myLife = '/my_life';
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
