// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) {
  return ArticleDetail(
    json['article_id'] as String,
    json['title'] as String,
    json['content'] as String,
    json['ctime'] as String,
    json['image_height'] as int,
  );
}

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'article_id': instance.articleId,
      'title': instance.title,
      'content': instance.content,
      'ctime': instance.ctime,
      'image_height': instance.imageHeight,
    };
