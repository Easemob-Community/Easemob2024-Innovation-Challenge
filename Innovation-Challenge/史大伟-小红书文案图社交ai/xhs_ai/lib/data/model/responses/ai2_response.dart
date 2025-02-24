import '../../../data/model/ai_model.dart';
import 'package:third_party_base/third_party_base.dart';

// part 'ai2_response.g.dart';

// @JsonSerializable()
// class Ai2Response{
//   String choices;
//
//
//   Ai2Response(this.status_code,this.text);
//
//   factory Ai2Response.fromJson(Map<String, dynamic> json) => _$Ai2ResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$Ai2ResponseToJson(this);
// }

import 'dart:convert';

class Ai2Response {
  String id;
  List<Choice> choices;
  int created;
  String model;
  String object;
  Usage usage;
  bool inputSensitive;
  bool outputSensitive;
  int inputSensitiveType;
  int outputSensitiveType;
  int outputSensitiveInt;
  BaseResp baseResp;

  Ai2Response({
    required this.id,
    required this.choices,
    required this.created,
    required this.model,
    required this.object,
    required this.usage,
    required this.inputSensitive,
    required this.outputSensitive,
    required this.inputSensitiveType,
    required this.outputSensitiveType,
    required this.outputSensitiveInt,
    required this.baseResp,
  });

  factory Ai2Response.fromJson(Map<String, dynamic> json) {
    return Ai2Response(
      id: json['id'] as String,
      choices: (json['choices'] as List).map((e) => Choice.fromJson(e as Map<String, dynamic>)).toList(),
      created: json['created'] as int,
      model: json['model'] as String,
      object: json['object'] as String,
      usage: Usage.fromJson(json['usage'] as Map<String, dynamic>),
      inputSensitive: json['input_sensitive'] as bool,
      outputSensitive: json['output_sensitive'] as bool,
      inputSensitiveType: json['input_sensitive_type'] as int,
      outputSensitiveType: json['output_sensitive_type'] as int,
      outputSensitiveInt: json['output_sensitive_int'] as int,
      baseResp: BaseResp.fromJson(json['base_resp'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'choices': choices.map((e) => e.toJson()).toList(),
      'created': created,
      'model': model,
      'object': object,
      'usage': usage.toJson(),
      'input_sensitive': inputSensitive,
      'output_sensitive': outputSensitive,
      'input_sensitive_type': inputSensitiveType,
      'output_sensitive_type': outputSensitiveType,
      'output_sensitive_int': outputSensitiveInt,
      'base_resp': baseResp.toJson(),
    };
  }
}

class Choice {
  String finishReason;
  int index;
  Message message;

  Choice({
    required this.finishReason,
    required this.index,
    required this.message,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      finishReason: json['finish_reason'] as String,
      index: json['index'] as int,
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'finish_reason': finishReason,
      'index': index,
      'message': message.toJson(),
    };
  }
}

class Message {
  String content;
  String role;
  String name;
  String audioContent;

  Message({
    required this.content,
    required this.role,
    required this.name,
    required this.audioContent,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'] as String,
      role: json['role'] as String,
      name: json['name'] as String,
      audioContent: json['audio_content'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'role': role,
      'name': name,
      'audio_content': audioContent,
    };
  }
}

class Usage {
  int totalTokens;
  int totalCharacters;
  int promptTokens;
  int completionTokens;

  Usage({
    required this.totalTokens,
    required this.totalCharacters,
    required this.promptTokens,
    required this.completionTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      totalTokens: json['total_tokens'] as int,
      totalCharacters: json['total_characters'] as int? ?? 0, // Assuming a default value of 0 if not present
      promptTokens: json['prompt_tokens'] as int,
      completionTokens: json['completion_tokens'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_tokens': totalTokens,
      'total_characters': totalCharacters,
      'prompt_tokens': promptTokens,
      'completion_tokens': completionTokens,
    };
  }
}

class BaseResp {
  int statusCode;
  String statusMsg;

  BaseResp({
    required this.statusCode,
    required this.statusMsg,
  });

  factory BaseResp.fromJson(Map<String, dynamic> json) {
    return BaseResp(
      statusCode: json['status_code'] as int,
      statusMsg: json['status_msg'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status_code': statusCode,
      'status_msg': statusMsg,
    };
  }
}