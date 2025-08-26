
import 'package:json_annotation/json_annotation.dart';

part 'Review.g.dart';

@JsonSerializable()
class Review{
  String id;
  String recipeId;
  String reviewedByName;
  DateTime time;
  String comment;
  @JsonKey(defaultValue: [])
  List<String> likes;
  @JsonKey(defaultValue: [])
  List<String> dislikes;

  Review(
  this.id, 
  this.recipeId,
  this.reviewedByName,
  this.time,
  this.comment,
  this.likes,
  this.dislikes,
  );
  
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}