// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat2_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat2Model _$Chat2ModelFromJson(Map<String, dynamic> json) => Chat2Model(
      json['role'] as String,
      json['name'] as String,
      json['content'] as String,
    );

Map<String, dynamic> _$Chat2ModelToJson(Chat2Model instance) => <String, dynamic>{
      'role': instance.role,
      'name': instance.name,
      'content': instance.content,
    };
