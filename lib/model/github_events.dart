import 'package:json_annotation/json_annotation.dart';

part 'github_events.g.dart';

List<GithubEvent> getGithubEventList(List<dynamic> list) {
  List<GithubEvent> result = [];
  list.forEach((item) {
    result.add(GithubEvent.fromJson(item));
  });
  return result;
}

@JsonSerializable()
class GithubEvent extends Object {
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'actor')
  Actor actor;

  @JsonKey(name: 'repo')
  Repo repo;

  @JsonKey(name: 'payload')
  Payload payload;

  @JsonKey(name: 'public')
  bool public;

  @JsonKey(name: 'created_at')
  String createdAt;

  GithubEvent(
    this.id,
    this.type,
    this.actor,
    this.repo,
    this.payload,
    this.public,
    this.createdAt,
  );

  factory GithubEvent.fromJson(Map<String, dynamic> srcJson) =>
      _$GithubEventFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GithubEventToJson(this);
}

@JsonSerializable()
class Actor extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'login')
  String login;

  @JsonKey(name: 'display_login')
  String displayLogin;

  @JsonKey(name: 'gravatar_id')
  String gravatarId;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  Actor(
    this.id,
    this.login,
    this.displayLogin,
    this.gravatarId,
    this.url,
    this.avatarUrl,
  );

  factory Actor.fromJson(Map<String, dynamic> srcJson) =>
      _$ActorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActorToJson(this);
}

@JsonSerializable()
class Repo extends Object {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'url')
  String url;

  Repo(
    this.id,
    this.name,
    this.url,
  );

  factory Repo.fromJson(Map<String, dynamic> srcJson) =>
      _$RepoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RepoToJson(this);
}

@JsonSerializable()
class Payload extends Object {
  @JsonKey(name: 'push_id')
  int pushId;

  @JsonKey(name: 'size')
  int size;

  @JsonKey(name: 'distinct_size')
  int distinctSize;

  @JsonKey(name: 'ref')
  String ref;

  @JsonKey(name: 'head')
  String head;

  @JsonKey(name: 'before')
  String before;

  @JsonKey(name: 'commits')
  List<Commits> commits;

  @JsonKey(name: 'action')
  String action;

  @JsonKey(name: 'member')
  Map<String, dynamic> member;

  @JsonKey(name: 'issue')
  Map<String, dynamic> issue;

  Payload(this.pushId, this.size, this.distinctSize, this.ref, this.head,
      this.before, this.commits, this.action, this.member, this.issue);

  factory Payload.fromJson(Map<String, dynamic> srcJson) =>
      _$PayloadFromJson(srcJson);

  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}

@JsonSerializable()
class Commits extends Object {
  @JsonKey(name: 'sha')
  String sha;

  @JsonKey(name: 'author')
  Author author;

  @JsonKey(name: 'message')
  String message;

  @JsonKey(name: 'distinct')
  bool distinct;

  @JsonKey(name: 'url')
  String url;

  Commits(
    this.sha,
    this.author,
    this.message,
    this.distinct,
    this.url,
  );

  factory Commits.fromJson(Map<String, dynamic> srcJson) =>
      _$CommitsFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CommitsToJson(this);
}

@JsonSerializable()
class Author extends Object {
  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'name')
  String name;

  Author(
    this.email,
    this.name,
  );

  factory Author.fromJson(Map<String, dynamic> srcJson) =>
      _$AuthorFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
