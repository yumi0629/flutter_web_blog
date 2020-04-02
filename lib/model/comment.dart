import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

List<Comment> getCommentList(List<dynamic> list) {
  List<Comment> result = [];
  list.forEach((item) {
    result.add(Comment.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class Comment extends Object {
  static final invalidId = -1;

  @JsonKey(name: 'comment_id')
  int commentId;

  @JsonKey(name: 'comment')
  String comment;

  @JsonKey(name: 'article_id')
  String articleId;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'user_name')
  String userName;

  @JsonKey(name: 'user_avatar')
  String userAvatar;

  @JsonKey(name: 'reply_id')
  int replyId;

  @JsonKey(name: 'reply_user_id')
  String replyUserId;

  @JsonKey(name: 'reply_user_name')
  String replyUserName;

  @JsonKey(name: 'post_id')
  String postId;

  @JsonKey(name: 'created')
  String created;

  Comment(
    this.commentId,
    this.comment,
    this.articleId,
    this.userId,
    this.userName,
    this.userAvatar,
    this.replyId,
    this.replyUserId,
    this.replyUserName,
    this.postId,
    this.created,
  );

  factory Comment.fromJson(Map<String, dynamic> srcJson) =>
      _$CommentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
