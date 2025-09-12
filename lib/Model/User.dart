import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String id,name, bio;
  @JsonKey(defaultValue: '')
  String profilePicURL;
  @JsonKey(defaultValue: 'Unknown')
  String city;
  @JsonKey(defaultValue: 'Unknown')
  String country;
  List<String> followers;
  List<String> following;
  List<String> viewedRecipes;
  List<String> savedRecipes;

  User(this.id,this.name, this.bio, this.profilePicURL,this.city,this.country, this.followers,this.following, this.viewedRecipes, this.savedRecipes);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
