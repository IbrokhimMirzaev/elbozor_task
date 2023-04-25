// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      id: json['id'] as int? ?? 0,
      codeName: json['codename'] as String? ?? '',
      typeId: json['type_id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      thumb: json['thumb'] as String? ?? '',
      added: json['added'] as String? ?? '',
      updated: json['updated'] as String? ?? '',
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'id': instance.id,
      'codename': instance.codeName,
      'type_id': instance.typeId,
      'title': instance.title,
      'thumb': instance.thumb,
      'added': instance.added,
      'updated': instance.updated,
    };
