import 'package:balcony/data/model/response/property_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'support_ticket_data.g.dart';

@JsonSerializable()
class SupportTicketData {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "workspace")
  WorkspaceData? workspace;

  @JsonKey(name: "property")
  PropertyData? property;

  @JsonKey(name: "conversation")
  List<Conversation>? conversation;

  @JsonKey(name: "status")
  String? status;

  SupportTicketData({
    this.id,
    this.workspace,
    this.property,
    this.conversation,
    this.status,
  });

  factory SupportTicketData.fromJson(Map<String, dynamic> json) =>
      _$SupportTicketDataFromJson(json);

  Map<String, dynamic> toJson() => _$SupportTicketDataToJson(this);
}

@JsonSerializable()
class Conversation {
  @JsonKey(name: "from")
  String? from;

  @JsonKey(name: "context")
  String? context;

  @JsonKey(name: "sendOn")
  String? sendOn;

  Conversation({this.from, this.context, this.sendOn});

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
