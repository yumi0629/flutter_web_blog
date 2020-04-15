// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubEvent _$GithubEventFromJson(Map<String, dynamic> json) {
  return GithubEvent(
    json['id'] as String,
    json['type'] as String,
    json['actor'] == null
        ? null
        : Actor.fromJson(json['actor'] as Map<String, dynamic>),
    json['repo'] == null
        ? null
        : Repo.fromJson(json['repo'] as Map<String, dynamic>),
    json['payload'] == null
        ? null
        : Payload.fromJson(json['payload'] as Map<String, dynamic>),
    json['public'] as bool,
    json['created_at'] as String,
  );
}

Map<String, dynamic> _$GithubEventToJson(GithubEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'actor': instance.actor,
      'repo': instance.repo,
      'payload': instance.payload,
      'public': instance.public,
      'created_at': instance.createdAt,
    };

Actor _$ActorFromJson(Map<String, dynamic> json) {
  return Actor(
    json['id'] as int,
    json['login'] as String,
    json['display_login'] as String,
    json['gravatar_id'] as String,
    json['url'] as String,
    json['avatar_url'] as String,
  );
}

Map<String, dynamic> _$ActorToJson(Actor instance) => <String, dynamic>{
      'id': instance.id,
      'login': instance.login,
      'display_login': instance.displayLogin,
      'gravatar_id': instance.gravatarId,
      'url': instance.url,
      'avatar_url': instance.avatarUrl,
    };

Repo _$RepoFromJson(Map<String, dynamic> json) {
  return Repo(
    json['id'] as int,
    json['name'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$RepoToJson(Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };

Payload _$PayloadFromJson(Map<String, dynamic> json) {
  return Payload(
    json['push_id'] as int,
    json['size'] as int,
    json['distinct_size'] as int,
    json['ref'] as String,
    json['head'] as String,
    json['before'] as String,
    (json['commits'] as List)
        ?.map((e) =>
            e == null ? null : Commits.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['action'] as String,
    json['member'] as Map<String, dynamic>,
    json['issue'] as Map<String, dynamic>,
  );
}

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'push_id': instance.pushId,
      'size': instance.size,
      'distinct_size': instance.distinctSize,
      'ref': instance.ref,
      'head': instance.head,
      'before': instance.before,
      'commits': instance.commits,
      'action': instance.action,
      'member': instance.member,
      'issue': instance.issue,
    };

Commits _$CommitsFromJson(Map<String, dynamic> json) {
  return Commits(
    json['sha'] as String,
    json['author'] == null
        ? null
        : Author.fromJson(json['author'] as Map<String, dynamic>),
    json['message'] as String,
    json['distinct'] as bool,
    json['url'] as String,
  );
}

Map<String, dynamic> _$CommitsToJson(Commits instance) => <String, dynamic>{
      'sha': instance.sha,
      'author': instance.author,
      'message': instance.message,
      'distinct': instance.distinct,
      'url': instance.url,
    };

Author _$AuthorFromJson(Map<String, dynamic> json) {
  return Author(
    json['email'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$AuthorToJson(Author instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
    };
