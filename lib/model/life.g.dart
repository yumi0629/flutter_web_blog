// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'life.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Life _$LifeFromJson(Map<String, dynamic> json) {
  return Life(
    json['post_id'] as int,
    (json['images'] as List)?.map((e) => e as String)?.toList(),
    json['content'] as String,
    json['created'] as String,
  );
}

Map<String, dynamic> _$LifeToJson(Life instance) => <String, dynamic>{
      'post_id': instance.postId,
      'images': instance.images,
      'content': instance.content,
      'created': instance.created,
    };
