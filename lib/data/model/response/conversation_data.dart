import 'package:homework/data/model/response/message_data.dart';
import 'package:homework/data/model/response/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_data.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ConversationData {
  @JsonKey(name: '_id')
  final String? Id;
  @JsonKey(name: 'host')
  final UserData? host;
  @JsonKey(name: 'user')
  final UserData? user;
  @JsonKey(name: 'lastMessage')
  final MessageData? lastMessage;
  @JsonKey(name: 'seen')
  final bool? seen;
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  ConversationData(
      {this.Id,
      this.host,
      this.lastMessage,
      this.user,
      this.seen,
      this.createdAt,
      this.updatedAt});

  factory ConversationData.fromJson(Map<String, dynamic> json) =>
      _$ConversationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDataToJson(this);
}
