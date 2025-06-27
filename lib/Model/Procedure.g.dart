// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Procedure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Procedure _$ProcedureFromJson(Map<String, dynamic> json) => Procedure(
      json['id'] as String,
      (json['stepNo'] as num).toInt(),
      json['procedure'] as String,
    );

Map<String, dynamic> _$ProcedureToJson(Procedure instance) => <String, dynamic>{
      'id': instance.id,
      'stepNo': instance.stepNo,
      'procedure': instance.procedure,
    };
