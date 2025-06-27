import 'package:json_annotation/json_annotation.dart';
import 'package:recipe_app/Model/Ingredient.dart';

part 'Recipe.g.dart';

@JsonSerializable(explicitToJson: true)
class Recipe {

  String id;
  String name;
  List<Ingredient> ingredients;
  List<String> procedure;
  String chefId;

  Recipe(
    this.id,
  this.name,
  this.ingredients,
  this.procedure,
  this.chefId
  );
  
  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
  
}