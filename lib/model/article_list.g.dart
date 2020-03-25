// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleListData _$ArticleListDataFromJson(Map<String, dynamic> json) {
  return ArticleListData(
    json['total'] as int,
    (json['entrylist'] as List)
        ?.map((e) => e == null
            ? null
            : ArticleListBean.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ArticleListDataToJson(ArticleListData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'entrylist': instance.list,
    };

ArticleListBean _$ArticleListBeanFromJson(Map<String, dynamic> json) {
  return ArticleListBean(
    (json['tags'] as List)
        ?.map((e) => e == null ? null : Tag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['buildTime'] as num)?.toDouble(),
    json['updatedAt'] as String,
    json['originalUrl'] as String,
    json['createdAt'] as String,
    json['content'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$ArticleListBeanToJson(ArticleListBean instance) =>
    <String, dynamic>{
      'tags': instance.tags,
      'buildTime': instance.buildTime,
      'updatedAt': instance.updatedAt,
      'originalUrl': instance.originalUrl,
      'createdAt': instance.createdAt,
      'content': instance.content,
      'title': instance.title,
    };

Tag _$TagFromJson(Map<String, dynamic> json) {
  return Tag(
    json['title'] as String,
    json['id'] as String,
  );
}

Map<String, dynamic> _$TagToJson(Tag instance) => <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
    };
