import 'package:flutter/material.dart';
import 'package:yumi_note/model/article_list.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';
import 'package:yumi_note/model/article_detail.dart';

class ArticleListProvider with ChangeNotifier {
  List<ArticleListBean> articles = [];

  int total = 0;

  bool get shouldLoadData => total == 0 || total > articles.length;

  ArticleListProvider() {
    getArticleList();
  }

  Future<void> getArticleList([String before]) async {
    if (shouldLoadData) {
      print('getArticleList start');
      DioClient.get('${Api.articleList}',
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

class ArticleDetailProvider with ChangeNotifier {
  String content = '';
  final String postId;
  final String title;
  final String createdAt;
  int imageHeight = 0;

  ArticleDetailProvider(
      {@required this.postId, @required this.title, @required this.createdAt}) {
    debugPrint('ArticleDetailProvider init');
    if (content == '') getArticleDetail();
  }

  void getArticleDetail() {
    DioClient.get('${Api.articleDetail}$postId', success: (data) {
      ArticleDetail detail = ArticleDetail.fromJson(data);
      imageHeight = detail.imageHeight;
      if (imageHeight == 0) // 无图
        imageHeight = 100;
      content = detail.content;
      notifyListeners();
    });
  }
}
