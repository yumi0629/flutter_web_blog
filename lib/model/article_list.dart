import 'package:json_annotation/json_annotation.dart';

part 'article_list.g.dart';


@JsonSerializable()
class ArticleList extends Object {

  @JsonKey(name: 'article_info')
  List<ArticleInfo> articleInfo;

  @JsonKey(name: 'count')
  int count;

  ArticleList(this.articleInfo,this.count,);

  factory ArticleList.fromJson(Map<String, dynamic> srcJson) => _$ArticleListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleListToJson(this);

}


@JsonSerializable()
class ArticleInfo extends Object {

  @JsonKey(name: 'article_id')
  String articleId;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'brief_content')
  String briefContent;

  @JsonKey(name: 'ctime')
  String ctime;

  ArticleInfo(this.articleId,this.title,this.briefContent,this.ctime,);

  factory ArticleInfo.fromJson(Map<String, dynamic> srcJson) => _$ArticleInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleInfoToJson(this);

}


