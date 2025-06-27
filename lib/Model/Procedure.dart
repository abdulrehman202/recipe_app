
import 'package:json_annotation/json_annotation.dart';

part 'Procedure.g.dart';

@JsonSerializable()
class Procedure{
  String id;
  int stepNo;
  String procedure;

  Procedure(
    this.id,
    this.stepNo,
    this.procedure
  );
  
  factory Procedure.fromJson(Map<String, dynamic> json) => _$ProcedureFromJson(json);
  Map<String, dynamic> toJson() => _$ProcedureToJson(this);
}