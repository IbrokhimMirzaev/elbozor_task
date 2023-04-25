import 'package:json_annotation/json_annotation.dart';

part 'data_model.g.dart';

@JsonSerializable()
class DataModel {
  @JsonKey(defaultValue: 0, name: "id")
  int id;

  @JsonKey(defaultValue: "", name: "codename")
  String codeName;

  @JsonKey(defaultValue: 0, name: "type_id")
  int typeId;

  @JsonKey(defaultValue: "", name: "title")
  String title;

  @JsonKey(defaultValue: "", name: "thumb")
  String thumb;

  @JsonKey(defaultValue: "", name: "added")
  String added;

  @JsonKey(defaultValue: "", name: "updated")
  String updated;

  DataModel({
    required this.id,
    required this.codeName,
    required this.typeId,
    required this.title,
    required this.thumb,
    required this.added,
    required this.updated,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => _$DataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
