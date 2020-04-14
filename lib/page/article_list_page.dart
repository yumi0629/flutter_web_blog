import 'package:extended_list/extended_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/model/article_list.dart';
import 'package:yumi_note/provider/article_provider.dart';
import 'package:yumi_note/util/date_helper.dart';
import 'package:yumi_note/util/route.dart';

class ArticleListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('_ArticleListState build()');
    return ChangeNotifierProvider<ArticleListProvider>.value(
        value: ArticleListProvider(),
        child: Builder(builder: (ctx) {
          List<ArticleListBean> articles =
              Provider.of<ArticleListProvider>(ctx).articles;
          return ExtendedListView.builder(
            itemCount: articles?.length ?? 0,
            itemBuilder: (_, index) {
              if (index == articles.length - 1) {
                Provider.of<ArticleListProvider>(ctx)
                    .getArticleList(articles.last.createdAt);
              }
              ArticleListBean article = articles[index];
              return GestureDetector(
                child: Card(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
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
                          article.createdAt.format(),
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
                        'createdAt': article.createdAt.format(),
                      });
                },
              );
            },
          );
        }));
  }
}
