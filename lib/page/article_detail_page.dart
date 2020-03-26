import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;
import 'package:yumi_note/model/article_detail.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  final NodeValidator _validator = NodeValidatorBuilder.common()
    ..allowElement('img', attributes: ['src'], uriPolicy: _AllowUriPolicy())
    ..allowElement('a', attributes: ['href'], uriPolicy: _AllowUriPolicy());
  final HtmlHtmlElement htmlElement = HtmlHtmlElement()..style.border = 'none';

  String postId;
  String title;
  String createdAt;
  int imageHeight = 0;
  String timeStamp = '';

  @override
  void didChangeDependencies() {
    print('_ArticleDetailState didChangeDependencies');
    super.didChangeDependencies();
    if (postId == null) {
      Map<String, String> arguments = ModalRoute.of(context).settings.arguments;
      postId = arguments['postId'];
      title = arguments['title'];
      createdAt = arguments['createdAt'];
      timeStamp = DateTime.now().toString();
      ui.platformViewRegistry
          .registerViewFactory(timeStamp, (int viewId) => htmlElement);
      getArticleDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('clientHeight = ${htmlElement.clientHeight}');
    print('scrollHeight = ${htmlElement.scrollHeight}');
    print('offsetHeight = ${htmlElement.offsetHeight}');
    print('imageHeight = $imageHeight');
    Widget body = SizedBox(
      height: htmlElement.scrollHeight.toDouble() + imageHeight,
      child: HtmlElementView(
        viewType: timeStamp,
      ),
    );
    return Container(
      padding: EdgeInsets.all(40),
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Container(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              color: Colors.black87,
            ),
          ),
          Container(
            height: 20,
          ),
          Text(
            createdAt,
            style: TextStyle(
              color: Colors.black26,
            ),
          ),
          Container(
            height: 20,
          ),
          body,
          _buildCommentInput(),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          'images/yumi_header.png',
          width: 50,
          height: 50,
        ),
        Container(
          width: 20.0,
        ),
        Expanded(
          child: SizedBox(
            height: 100,
            child: CupertinoTextField(
              padding: EdgeInsets.all(12),
              maxLength: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border(
                  top: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black12),
                  right: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black12),
                  bottom: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black12),
                  left: BorderSide(
                      width: 1.0,
                      style: BorderStyle.solid,
                      color: Colors.black12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void getArticleDetail() {
    DioClient.get('${Api.articleDetail}$postId', success: (data) {
      ArticleDetail detail = ArticleDetail.fromJson(data);
      htmlElement.setInnerHtml(detail.content, validator: _validator);
      imageHeight = detail.imageHeight;
      if (imageHeight == 0) // 无图
        imageHeight = 100;
      setState(() {});
    });
  }
}

class _AllowUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) {
    return true;
  }
}
