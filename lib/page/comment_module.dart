import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:yumi_note/model/comment.dart';
import 'package:yumi_note/provider/comment_provider.dart';
import 'package:yumi_note/util/app_info.dart';

class CommentListModule extends StatelessWidget {
  final CommentProvider provider;
  final CommentAddProvider addProvider;

  const CommentListModule(
      {Key key, @required this.provider, @required this.addProvider})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (addProvider.needRefresh) {
      addProvider.needRefresh = false;
      provider.getComments();
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.comments == null ? 0 : provider.comments.length,
        itemBuilder: (_, index) {
          if (provider.comments == null) return Container(height: 0);
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
              errorBuilder: (_, __, ___) {
                return Image.asset(
                  'images/yumi_header.png',
                  width: 45,
                  height: 45,
                  fit: BoxFit.cover,
                );
              },
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
                                EasyLoading.showToast("请先登录哦");
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
}

class CommentInputModule extends StatefulWidget {
  final CommentAddProvider provider;

  const CommentInputModule({Key key, @required this.provider})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentInputState();
}

class CommentInputState extends State<CommentInputModule> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommentAddProvider provider = widget.provider;
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
                        Comment comment;
                        if (provider.commentType == CommentType.typeArticle) {
                          comment = Comment(
                              Comment.invalidId,
                              _controller.text,
                              provider.id,
                              AppInfo.getInstance().user.id.toString(),
                              AppInfo.getInstance().user.name,
                              AppInfo.getInstance().user.avatarUrl,
                              provider.replyId,
                              provider.replyUserId,
                              provider.replyUserName,
                              '',
                              '');
                        } else if (provider.commentType ==
                            CommentType.typeLife) {
                          comment = Comment(
                              Comment.invalidId,
                              _controller.text,
                              '',
                              AppInfo.getInstance().user.id.toString(),
                              AppInfo.getInstance().user.name,
                              AppInfo.getInstance().user.avatarUrl,
                              provider.replyId,
                              provider.replyUserId,
                              provider.replyUserName,
                              provider.id,
                              '');
                        }
                        provider.addComment(comment);
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

class CommentSpin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
              fontSize: 20, color: Colors.black87, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
