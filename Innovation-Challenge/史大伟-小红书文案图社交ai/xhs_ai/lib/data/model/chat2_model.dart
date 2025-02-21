import 'package:third_party_base/third_party_base.dart';

part 'chat2_model.g.dart';

@JsonSerializable()
class Chat2Model{
  String role;
  String name;
  String content;


  Chat2Model(this.role, this.name, this.content);

  factory Chat2Model.fromJson(Map<String, dynamic> json) => _$Chat2ModelFromJson(json);
  Map<String, dynamic> toJson() => _$Chat2ModelToJson(this);
}