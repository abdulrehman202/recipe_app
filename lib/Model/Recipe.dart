import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_app/Model/Ingredient.dart';
import 'package:recipe_app/Model/Procedure.dart';

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
  int? totalRating;
  int? totalUsersWhoRated;

  Recipe(
    this.id,
  this.name,
  this.duration,
  this.categoryId,
  this.ingredients,
  this.procedure,
  this.chefId,
  this.totalRating,
  this.totalUsersWhoRated,
  );
  
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
  
}