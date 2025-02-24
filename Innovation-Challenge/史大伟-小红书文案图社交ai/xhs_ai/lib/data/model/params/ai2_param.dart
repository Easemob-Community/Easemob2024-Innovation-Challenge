import 'package:third_party_base/third_party_base.dart';

import '../chat2_model.dart';
import '../chat_model.dart';

part 'ai2_param.g.dart';

@JsonSerializable()
class Ai2Parma{
  String model;
  List<Chat2Model> messages;


  Ai2Parma( this.model, this.messages);

  factory Ai2Parma.fromJson(Map<String, dynamic> json) => _$Ai2ParmaFromJson(json);
  Map<String, dynamic> toJson() => _$Ai2ParmaToJson(this);
}