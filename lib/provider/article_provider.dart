import 'package:flutter/material.dart';
import 'package:yumi_note/model/article_list.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';

class ArticleLisProvider with ChangeNotifier {
  final String targetUid = '5b96160b5188255c5b5c1bab';

  List<ArticleListBean> articles = [];

  int total = 0;

  bool get shouldLoadData => total == 0 || total > articles.length;

  ArticleLisProvider() {
    getArticleList();
  }

  Future<void> getArticleList([String before]) async {
    if (shouldLoadData) {
      print('getArticleList start');
      DioClient.get('${Api.articleList}$targetUid',
          queryParameters: {'before': before}, success: (data) {
        print('getArticleList success');
        ArticleListData d = ArticleListData.fromJson(data);
        total = d.total;
        if (total == 0) articles.clear();
        articles.addAll(d.list);
        notifyListeners();
      });
    }
  }
}

class ArticleDetailProvider{

}
