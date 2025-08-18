// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      json['id'] as String,
      json['recipeId'] as String,
      json['reviewedByName'] as String,
      DateTime.parse(json['time'] as String),
      json['comment'] as String,
      (json['likes'] as num).toInt(),
      (json['dislikes'] as num).toInt(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'recipeId': instance.recipeId,
      'reviewedByName': instance.reviewedByName,
      'time': instance.time.toIso8601String(),
      'comment': instance.comment,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
    };
