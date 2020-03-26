import 'package:json_annotation/json_annotation.dart';

part 'about_me.g.dart';

@JsonSerializable()
class AboutMe extends Object {
  @JsonKey(name: 'data')
  List<Introduction> data;

  @JsonKey(name: 's')
  int s;

  @JsonKey(name: 'm')
  String m;

  AboutMe(
    this.data,
    this.s,
    this.m,
  );

  factory AboutMe.fromJson(Map<String, dynamic> srcJson) =>
      _$AboutMeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AboutMeToJson(this);
}

@JsonSerializable()
class Introduction extends Object {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'image')
  List<String> image;

  Introduction(
    this.title,
    this.content,
    this.image,
  );

  factory Introduction.fromJson(Map<String, dynamic> srcJson) =>
      _$IntroductionFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IntroductionToJson(this);
}
