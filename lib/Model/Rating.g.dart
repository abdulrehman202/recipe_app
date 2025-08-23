// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
      json['uid'] as String,
      (json['rating'] as num).toInt(),
    );

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
      'uid': instance.uid,
      'rating': instance.rating,
    };
