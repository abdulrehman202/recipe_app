// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['name'] as String,
      json['bio'] as String,
      (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['following'] as List<dynamic>).map((e) => e as String).toList(),
      (json['viewedRecipes'] as List<dynamic>).map((e) => e as String).toList(),
      (json['savedRecipes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'bio': instance.bio,
      'followers': instance.followers,
      'following': instance.following,
      'viewedRecipes': instance.viewedRecipes,
      'savedRecipes': instance.savedRecipes,
    };
