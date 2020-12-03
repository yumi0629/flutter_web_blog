// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleList _$ArticleListFromJson(Map<String, dynamic> json) {
  return ArticleList(
    (json['article_info'] as List)
        ?.map((e) =>
            e == null ? null : ArticleInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['count'] as int,
  );
}

Map<String, dynamic> _$ArticleListToJson(ArticleList instance) =>
    <String, dynamic>{
      'article_info': instance.articleInfo,
      'count': instance.count,
    };

ArticleInfo _$ArticleInfoFromJson(Map<String, dynamic> json) {
  return ArticleInfo(
    json['article_id'] as String,
    json['title'] as String,
    json['brief_content'] as String,
    json['ctime'] as String,
  );
}

Map<String, dynamic> _$ArticleInfoToJson(ArticleInfo instance) =>
    <String, dynamic>{
      'article_id': instance.articleId,
      'title': instance.title,
      'brief_content': instance.briefContent,
      'ctime': instance.ctime,
    };
