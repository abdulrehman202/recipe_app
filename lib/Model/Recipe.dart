import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_app/Model/Ingredient.dart';
import 'package:recipe_app/Model/Procedure.dart';
import 'package:recipe_app/Model/Rating.dart';

part 'Recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class Recipe {

  String id;
  String name;
  int duration;
  int? categoryId;
  List<Ingredient> ingredients;
  List<Procedure> procedure;
  String chefId;
  @JsonKey(defaultValue: 0)
  int totalRating;
  @JsonKey(defaultValue: [])
  List<Rating> usersWhoRated;
  @JsonKey(defaultValue: '')
  String imgUrl;

  Recipe(
    this.id,
  this.name,
  this.duration,
  this.categoryId,
  this.ingredients,
  this.procedure,
  this.chefId,
  this.totalRating,
  this.usersWhoRated,
  this.imgUrl,
  );
  
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
  
}