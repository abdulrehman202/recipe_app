// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      json['id'] as String,
      json['name'] as String,
      (json['duration'] as num).toInt(),
      (json['categoryId'] as num?)?.toInt(),
      (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['procedure'] as List<dynamic>)
          .map((e) => Procedure.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['chefId'] as String,
      (json['totalRating'] as num?)?.toInt() ?? 0,
      (json['usersWhoRated'] as List<dynamic>?)
              ?.map((e) => Rating.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duration': instance.duration,
      'categoryId': instance.categoryId,
      'ingredients': instance.ingredients.map((e) => e.toJson()).toList(),
      'procedure': instance.procedure.map((e) => e.toJson()).toList(),
      'chefId': instance.chefId,
      'totalRating': instance.totalRating,
      'usersWhoRated': instance.usersWhoRated.map((e) => e.toJson()).toList(),
    };
