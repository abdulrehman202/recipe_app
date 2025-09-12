// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as String,
      json['name'] as String,
      json['bio'] as String,
      json['profilePicURL'] as String? ?? '',
      json['city'] as String? ?? 'Unknown',
      json['country'] as String? ?? 'Unknown',
      (json['followers'] as List<dynamic>).map((e) => e as String).toList(),
      (json['following'] as List<dynamic>).map((e) => e as String).toList(),
      (json['viewedRecipes'] as List<dynamic>).map((e) => e as String).toList(),
      (json['savedRecipes'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'bio': instance.bio,
      'profilePicURL': instance.profilePicURL,
      'city': instance.city,
      'country': instance.country,
      'followers': instance.followers,
      'following': instance.following,
      'viewedRecipes': instance.viewedRecipes,
      'savedRecipes': instance.savedRecipes,
    };
