import 'package:json_annotation/json_annotation.dart';

part 'github_user.g.dart';


@JsonSerializable()
class GithubUser extends Object {

  @JsonKey(name: 'access_token')
  String accessToken;

  @JsonKey(name: 'login')
  String login;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'avatar_url')
  String avatarUrl;

  GithubUser(this.accessToken,this.login,this.id,this.name,this.avatarUrl,);

  factory GithubUser.fromJson(Map<String, dynamic> srcJson) => _$GithubUserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$GithubUserToJson(this);

}