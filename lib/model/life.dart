import 'package:json_annotation/json_annotation.dart';

part 'life.g.dart';


List<Life> getLifeList(List<dynamic> list){
  List<Life> result = [];
  list.forEach((item){
    result.add(Life.fromJson(item));
  });
  return result;
}
@JsonSerializable()
class Life extends Object {

  @JsonKey(name: 'post_id')
  int postId;

  @JsonKey(name: 'images')
  List<String> images;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'created')
  String created;

  Life(this.postId,this.images,this.content,this.created,);

  factory Life.fromJson(Map<String, dynamic> srcJson) => _$LifeFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LifeToJson(this);

}
