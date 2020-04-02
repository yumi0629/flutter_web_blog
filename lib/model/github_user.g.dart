// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubUser _$GithubUserFromJson(Map<String, dynamic> json) {
  return GithubUser(
    json['access_token'] as String,
    json['login'] as String,
    json['id'] as int,
    json['name'] as String,
    json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$GithubUserToJson(GithubUser instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'login': instance.login,
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };
