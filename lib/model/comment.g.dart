// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    json['comment_id'] as int,
    json['comment'] as String,
    json['article_id'] as String,
    json['user_id'] as String,
    json['user_name'] as String,
    json['user_avatar'] as String,
    json['reply_id'] as int,
    json['reply_user_id'] as String,
    json['reply_user_name'] as String,
    json['post_id'] as String,
    json['created'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'comment_id': instance.commentId,
      'comment': instance.comment,
      'article_id': instance.articleId,
      'user_id': instance.userId,
      'user_name': instance.userName,
      'user_avatar': instance.userAvatar,
      'reply_id': instance.replyId,
      'reply_user_id': instance.replyUserId,
      'reply_user_name': instance.replyUserName,
      'post_id': instance.postId,
      'created': instance.created,
    };
