import 'package:json_annotation/json_annotation.dart';

part 'article_detail.g.dart';

@JsonSerializable()
class ArticleDetail {
  @JsonKey(name: 'entryViewId')
  String entryViewId;

  @JsonKey(name: 'entryId')
  String entryId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'transcodeContent')
  String transcodeContent;

  @JsonKey(name: 'imageCache')
  ImageCache imageCache;

  @JsonKey(name: 'auto')
  bool auto;

  @JsonKey(name: 'version')
  int version;

  @JsonKey(name: 'createdAt')
  String createdAt;

  @JsonKey(name: 'updatedAt')
  String updatedAt;

  @JsonKey(name: 'imageHeight')
  int imageHeight;

  ArticleDetail(
    this.entryViewId,
    this.entryId,
    this.content,
    this.transcodeContent,
    this.imageCache,
    this.auto,
    this.version,
    this.createdAt,
    this.updatedAt,
    this.imageHeight,
  );

  factory ArticleDetail.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleDetailFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ArticleDetailToJson(this);
}

@JsonSerializable()
class ImageCache {
  @JsonKey(name: 'imageUrlArray')
  List<dynamic> imageUrlArray;

  ImageCache(
    this.imageUrlArray,
  );

  factory ImageCache.fromJson(Map<String, dynamic> srcJson) =>
      _$ImageCacheFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ImageCacheToJson(this);
}
