import 'dart:html';
import 'dart:convert' as convert;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yumi_note/model/comment.dart';
import 'package:yumi_note/network/api.dart';
import 'package:yumi_note/network/dio_client.dart';
import 'package:yumi_note/util/app_info.dart';

class CommentProvider with ChangeNotifier {
  final CommentType commentType;
  final String id;

  List<Comment> comments = [];

  int get type => commentType == CommentType.typeArticle
      ? 0
      : (commentType == CommentType.typeLife ? 1 : -1);

  CommentProvider({@required this.commentType, @required this.id}) {
    getComments();
  }

  void getComments() {
    DioClient.get('${Api.commentList}', queryParameters: {
      'type': type,
      "id": id,
    }, success: (data) {
      comments = getCommentList(data);
      notifyListeners();
    });
  }
}

class CommentAddProvider with ChangeNotifier {
  final CommentType commentType;
  final String id;

  int replyId = Comment.invalidId;
  String replyUserId;
  String replyUserName = '';

  bool needRefresh = false;

  bool clear = false;

  bool get enable => AppInfo.getInstance().user != null;

  int get type => commentType == CommentType.typeArticle
      ? 0
      : (commentType == CommentType.typeLife ? 1 : -1);

  CommentAddProvider({@required this.commentType, @required this.id});

  void addComment(Comment comment) {
    DioClient.post('${Api.commentAdd}',
        data: FormData.fromMap({
          'type': type,
          'comment': convert.jsonEncode(comment.toJson()),
        }), success: (data) {
      showToast('评论成功！');
      clear = true;
      needRefresh = true;
      resetReply(needRefresh: false);
      notifyListeners();
    });
  }

  void replyShow(int replyId, String replyUserId, String replyUserName) {
    if (this.replyId == replyId) return;
    this.replyId = replyId;
    this.replyUserId = replyUserId;
    this.replyUserName = replyUserName;
    notifyListeners();
  }

  void resetReply({bool needRefresh = true}) {
    this.replyId = Comment.invalidId;
    this.replyUserId = '';
    this.replyUserName = '';
    if (needRefresh) notifyListeners();
  }
}

enum CommentType {
  typeArticle,
  typeLife,
}
