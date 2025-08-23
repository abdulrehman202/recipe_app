
import 'package:json_annotation/json_annotation.dart';

part 'Rating.g.dart';
@JsonSerializable()
class Rating{
  String uid;
  int rating;

  Rating(this.uid, this.rating);

  
  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);
}