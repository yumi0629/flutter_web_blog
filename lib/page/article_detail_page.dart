import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/page/comment_module.dart';
import 'package:yumi_note/provider/article_provider.dart';
import 'package:yumi_note/provider/comment_provider.dart';
import 'package:markdown/markdown.dart' as md;

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:yumi_note/widget/markdown/syntax_highlighter.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  String postId;
  String title = '';
  String createdAt = '';

  @override
  void didChangeDependencies() {
    print('_ArticleDetailState didChangeDependencies');
    super.didChangeDependencies();
    if (postId == null) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context).settings.arguments;
      postId = arguments['postId'];
      title = arguments['title'];
      createdAt = arguments['createdAt'];
//      ui.platformViewRegistry
//          .registerViewFactory(timeStamp, (int viewId) => htmlElement);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ArticleDetailProvider(
            postId: postId,
            title: title,
            createdAt: createdAt,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentProvider(
            commentType: CommentType.typeArticle,
            id: postId,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => CommentAddProvider(
            commentType: CommentType.typeArticle,
            id: postId,
          ),
        ),
      ],
      child: Container(
        padding: EdgeInsets.all(40),
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Container(height: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 26,
                color: Colors.black87,
              ),
            ),
            Container(height: 20),
            Text(
              createdAt,
              style: TextStyle(
                color: Colors.black26,
              ),
            ),
            Container(height: 20),
            Consumer<ArticleDetailProvider>(
              builder: (_, detailProvider, ___) {
                return _buildArticleBody(detailProvider);
              },
            ),
            Container(height: 60),
            CommentSpin(),
            Container(height: 40),
            Consumer2<CommentProvider, CommentAddProvider>(
              builder: (_, commentProvider, commentAddProvider, ___) {
                return CommentListModule(
                    provider: commentProvider, addProvider: commentAddProvider);
              },
            ),
            Container(height: 30),
            Consumer<CommentAddProvider>(
              builder: (_, addProvider, ___) {
                return CommentInputModule(provider: addProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleBody(ArticleDetailProvider provider) {
    return MarkdownBody(
      onTapLink: (text, href, title) {
        js.context.callMethod('open', [href]);
      },
      extensionSet: md.ExtensionSet.gitHubWeb,
      syntaxHighlighter: _CodeHighlighter(),
      styleSheet: _markdownStyleSheet,
      shrinkWrap: true,
      selectable: false,
      data: provider.content,
    );
  }
}

MarkdownStyleSheet _markdownStyleSheet = MarkdownStyleSheet(
  h1: TextStyle(
    fontSize: 22,
    color: Colors.black,
    height: 1.5,
  ),
  h2: TextStyle(
    fontSize: 21,
    color: Colors.black,
    height: 1.5,
  ),
  h3: TextStyle(
    fontSize: 20,
    color: Colors.black,
    height: 1.5,
  ),
  h4: TextStyle(
    fontSize: 19,
    color: Colors.black,
    height: 1.5,
  ),
  h5: TextStyle(
    fontSize: 18,
    color: Colors.black,
    height: 1.5,
  ),
  h6: TextStyle(
    fontSize: 17,
    color: Colors.black,
    height: 1.5,
  ),
  a: const TextStyle(
      color: Colors.pinkAccent, decoration: TextDecoration.underline),
  p: TextStyle(
    fontSize: 16,
    color: Colors.black87,
    height: 1.5,
  ),
  blockSpacing: 12.0,
  blockquote: TextStyle(
    fontSize: 14,
    color: Colors.black54,
    height: 1.5,
  ),
  blockquoteDecoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(2.0),
  ),
  codeblockDecoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(2.0),
  ),
  codeblockPadding: const EdgeInsets.all(12.0),
  code: TextStyle(
      color: Colors.black87,
      fontFamily: 'Monaco',
      fontSize: 14,
      backgroundColor: Colors.grey.shade100),
);

class _CodeHighlighter extends SyntaxHighlighter {
  @override
  TextSpan format(String source) {
    return TextSpan(
      children: [
        DartSyntaxHighlighter(SyntaxHighlighterStyle.lightThemeStyle())
            .format(source),
      ],
    );
  }
}
