import 'package:extended_list/extended_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/model/article_list.dart';
import 'package:yumi_note/provider/article_provider.dart';
import 'package:yumi_note/util/date_helper.dart';
import 'package:yumi_note/util/route.dart';

import 'home.dart';

class ArticleListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleListPage> {
  @override
  Widget build(BuildContext context) {
    print('_ArticleListState build()');
    return ChangeNotifierProvider<ArticleLisProvider>.value(
        value: ArticleLisProvider(),
        child: Builder(builder: (ctx) {
          List<ArticleListBean> articles =
              Provider.of<ArticleLisProvider>(ctx).articles;
          return ExtendedListView.builder(
            itemCount: articles?.length ?? 0,
            itemBuilder: (_, index) {
              if (index == articles.length - 1) {
                Provider.of<ArticleLisProvider>(ctx)
                    .getArticleList(articles.last.createdAt);
              }
              ArticleListBean article = articles[index];
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  shadowColor: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          article.title,
                          style: TextStyle(fontSize: 22, color: Colors.black87),
                        ),
                        Container(
                          height: 12,
                        ),
                        Text(
                          DateHelper.formatTime(article.createdAt),
                          style: TextStyle(color: Colors.black26),
                        ),
                        Container(
                          height: 12,
                        ),
                        Text(
                          article.content,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Container(
                          height: 12,
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            '阅读全文',
                            style: TextStyle(color: Colors.black26),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  String originalUrl = article.originalUrl;
                  String postId =
                      originalUrl.substring(originalUrl.lastIndexOf('/') + 1);
                  print('onTap postId = $postId');
                  ArticleNavHelper.pushNamed(RouteName.articleDetail,
                      arguments: {
                        'postId': postId,
                        'title': article.title,
                        'createdAt': DateHelper.formatTime(article.createdAt),
                      });
                },
              );
            },
          );
        }));
  }
}
