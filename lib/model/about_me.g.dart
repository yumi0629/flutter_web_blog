// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_me.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutMe _$AboutMeFromJson(Map<String, dynamic> json) {
  return AboutMe(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Introduction.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['s'] as int,
    json['m'] as String,
  );
}

Map<String, dynamic> _$AboutMeToJson(AboutMe instance) => <String, dynamic>{
      'data': instance.data,
      's': instance.s,
      'm': instance.m,
    };

Introduction _$IntroductionFromJson(Map<String, dynamic> json) {
  return Introduction(
    json['title'] as String,
    json['content'] as String,
    (json['image'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$IntroductionToJson(Introduction instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'image': instance.image,
    };
