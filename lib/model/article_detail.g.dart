// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleDetail _$ArticleDetailFromJson(Map<String, dynamic> json) {
  return ArticleDetail(
    json['entryViewId'] as String,
    json['entryId'] as String,
    json['content'] as String,
    json['transcodeContent'] as String,
    json['imageCache'] == null
        ? null
        : ImageCache.fromJson(json['imageCache'] as Map<String, dynamic>),
    json['auto'] as bool,
    json['version'] as int,
    json['createdAt'] as String,
    json['updatedAt'] as String,
    json['imageHeight'] as int,
  );
}

Map<String, dynamic> _$ArticleDetailToJson(ArticleDetail instance) =>
    <String, dynamic>{
      'entryViewId': instance.entryViewId,
      'entryId': instance.entryId,
      'content': instance.content,
      'transcodeContent': instance.transcodeContent,
      'imageCache': instance.imageCache,
      'auto': instance.auto,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'imageHeight': instance.imageHeight,
    };

ImageCache _$ImageCacheFromJson(Map<String, dynamic> json) {
  return ImageCache(
    json['imageUrlArray'] as List,
  );
}

Map<String, dynamic> _$ImageCacheToJson(ImageCache instance) =>
    <String, dynamic>{
      'imageUrlArray': instance.imageUrlArray,
    };
