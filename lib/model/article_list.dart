import 'package:json_annotation/json_annotation.dart';

part 'article_list.g.dart';

@JsonSerializable()
class ArticleListData {
  @JsonKey(name: 'total')
  int total;

  @JsonKey(name: 'entrylist')
  List<ArticleListBean> list;

  ArticleListData(
    this.total,
    this.list,
  );

  factory ArticleListData.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleListDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleListDataToJson(this);
}

@JsonSerializable()
class ArticleListBean {
  @JsonKey(name: 'tags')
  List<Tag> tags;

  @JsonKey(name: 'buildTime')
  double buildTime;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'originalUrl')
  String originalUrl;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'title')
  String title;

  ArticleListBean(this.tags, this.buildTime, this.updatedAt, this.originalUrl,
      this.createdAt, this.content, this.title);

  factory ArticleListBean.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleListBeanToJson(this);
}

@JsonSerializable()
class Tag {
  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'id')
  String id;

  Tag(this.title, this.id);

  factory Tag.fromJson(Map<String, dynamic> srcJson) => _$TagFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
