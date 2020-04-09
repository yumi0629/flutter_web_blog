import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:yumi_note/model/comment.dart';
import 'package:yumi_note/provider/article_provider.dart';
import 'package:yumi_note/provider/comment_provider.dart';
import 'package:yumi_note/util/app_info.dart';
import 'package:markdown/markdown.dart' as md;

// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:yumi_note/widget/markdown/syntax_highlighter.dart';
import 'package:yumi_note/widget/markdown/custom_mark_down.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetailPage> {
  String postId;
  String title = '';
  String createdAt = '';
  String timeStamp = '';

  final TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    print('_ArticleDetailState didChangeDependencies');
    super.didChangeDependencies();
    if (postId == null) {
      Map<String, String> arguments = ModalRoute.of(context).settings.arguments;
      postId = arguments['postId'];
      postId = arguments['postId'];
      title = arguments['title'];
      createdAt = arguments['createdAt'];
      timeStamp = DateTime.now().toString();
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
            Consumer<ArticleDetailProvider>(
              builder: (_, detailProvider, ___) {
                return _buildArticleBody(detailProvider);
              },
            ),
            Container(
              height: 60,
            ),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 5),
                  width: 5,
                  height: 22,
                  color: Colors.pinkAccent,
                ),
                Container(
                  width: 16,
                ),
                Text(
                  '评论',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            Container(
              height: 30,
            ),
            Consumer2<CommentProvider, CommentAddProvider>(
              builder: (_, commentProvider, commentAddProvider, ___) {
                if (commentAddProvider.needRefresh) {
                  commentAddProvider.needRefresh = false;
                  commentProvider.getComments();
                }
                return _buildCommentList(commentProvider, commentAddProvider);
              },
            ),
            Container(
              height: 30,
            ),
            Consumer<CommentAddProvider>(
              builder: (_, addProvider, ___) {
                return _buildCommentInput(addProvider);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleBody(ArticleDetailProvider provider) {
    return YMMarkdown(
      onTapLink: (href) {
        js.context.callMethod('open', [href]);
      },
      extensionSet: md.ExtensionSet.gitHubWeb,
      syntaxHighlighter: _CodeHighlighter(),
      styleSheet: _markdownStyleSheet,
      shrinkWrap: true,
      selectable: false,
      data: provider.content,
      controller: ScrollController(),
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget _buildCommentList(
      CommentProvider provider, CommentAddProvider addProvider) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.comments.length,
        itemBuilder: (_, index) {
          Comment comment = provider.comments[index];
          Widget avatar;
          if (comment.userAvatar == null)
            avatar = Image.asset(
              'images/yumi_header.png',
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            );
          else
            avatar = Image.network(
              comment.userAvatar,
              width: 45,
              height: 45,
              fit: BoxFit.cover,
            );
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              avatar,
              Container(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: '${comment.userName}  ',
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                        children: [
                          TextSpan(
                            text: comment.created,
                            style:
                                TextStyle(color: Colors.black26, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: comment.replyId == Comment.invalidId
                            ? ""
                            : "@${comment.replyUserName}：",
                        style:
                            TextStyle(color: Colors.pinkAccent, fontSize: 14),
                        children: [
                          TextSpan(
                            text: comment.comment,
                            style:
                                TextStyle(color: Colors.black87, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: addProvider.enable
                            ? () {
                                addProvider.replyShow(comment.commentId,
                                    comment.userId, comment.userName);
                              }
                            : () {
                                showToast("请先登录哦");
                              },
                        child: Text(
                          '扔个大师球捕获他？',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: addProvider.enable
                                ? Colors.pinkAccent
                                : Colors.black26,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _buildCommentInput(CommentAddProvider provider) {
    if (provider.clear) _controller.text = '';
    Widget avatar;
    if (!AppInfo.getInstance().isLogin() ||
        AppInfo.getInstance().user.avatarUrl == null)
      avatar = Image.asset(
        'images/yumi_header.png',
        width: 45,
        height: 45,
        fit: BoxFit.cover,
      );
    else
      avatar = Image.network(
        AppInfo.getInstance().user.avatarUrl,
        width: 45,
        height: 45,
        fit: BoxFit.cover,
      );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        avatar,
        Container(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Visibility(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    deleteButtonTooltipMessage: '不想回复他了',
                    label: Text(
                      '@${provider.replyUserName}：',
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 14,
                      ),
                    ),
                    onDeleted: () {
                      provider.resetReply();
                    },
                  ),
                ),
                visible: provider.replyId != Comment.invalidId,
              ),
              SizedBox(
                height: 100,
                child: CupertinoTextField(
                  enabled: provider.enable,
                  controller: _controller,
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                  textAlignVertical: TextAlignVertical.top,
                  placeholder: provider.enable ? '请输入评论' : '请先登录哦~',
                  padding: EdgeInsets.all(12),
                  minLines: 2,
                  maxLines: 5,
                  maxLength: 300,
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
              Container(
                height: 8,
              ),
              MaterialButton(
                color: Colors.pinkAccent,
                disabledColor: Colors.black26,
                height: 32,
                elevation: 0,
                disabledElevation: 0,
                highlightElevation: 0,
                focusElevation: 0,
                hoverElevation: 0,
                onPressed: provider.enable
                    ? () {
                        provider.addComment(
                          Comment(
                              Comment.invalidId,
                              _controller.text,
                              postId,
                              AppInfo.getInstance().user.id.toString(),
                              AppInfo.getInstance().user.name,
                              AppInfo.getInstance().user.avatarUrl,
                              provider.replyId,
                              provider.replyUserId,
                              provider.replyUserName,
                              '',
                              ''),
                        );
                      }
                    : null,
                child: Text(
                  '添加评论',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
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
