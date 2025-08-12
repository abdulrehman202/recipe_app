import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  String name, bio;
  List<String> followers;
  List<String> following;
  List<String> viewedRecipes;
  List<String> savedRecipes;

  User(this.name, this.bio,this.followers,this.following, this.viewedRecipes, this.savedRecipes);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
