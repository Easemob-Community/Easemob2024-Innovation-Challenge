// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai2_param.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ai2Parma _$Ai2ParmaFromJson(Map<String, dynamic> json) => Ai2Parma(
      json['model'] as String,
      (json['messages'] as List<dynamic>)
          .map((e) => Chat2Model.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$Ai2ParmaToJson(Ai2Parma instance) => <String, dynamic>{
      'model': instance.model,
      'messages': instance.messages,
    };
