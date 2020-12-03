import 'package:json_annotation/json_annotation.dart';

part 'article_detail.g.dart';


@JsonSerializable()
class ArticleDetail extends Object {

  @JsonKey(name: 'article_id')
  String articleId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'ctime')
  String ctime;

  @JsonKey(name: 'image_height')
  int imageHeight;

  ArticleDetail(this.articleId,this.title,this.content,this.ctime,this.imageHeight,);

  factory ArticleDetail.fromJson(Map<String, dynamic> srcJson) => _$ArticleDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);

}