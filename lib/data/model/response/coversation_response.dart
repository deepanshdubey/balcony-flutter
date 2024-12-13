import 'package:json_annotation/json_annotation.dart'; 

part 'coversation_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class CoversationResponse {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'conversation')
  final  Conversation? conversation;

  CoversationResponse({this.success, this.conversation});

   factory CoversationResponse.fromJson(Map<String, dynamic> json) => _$CoversationResponseFromJson(json);

   Map<String, dynamic> toJson() => _$CoversationResponseToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Conversation {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'member')
  final  Member? member;
  @JsonKey(name: 'lastMessage')
  final  LastMessage? lastMessage;
  @JsonKey(name: 'seen')
  final  bool? seen;
  @JsonKey(name: 'createdAt')
  final  String? createdAt;
  @JsonKey(name: 'updatedAt')
  final  String? updatedAt;

  Conversation({this.Id, this.member, this.lastMessage, this.seen, this.createdAt, this.updatedAt});

   factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);

   Map<String, dynamic> toJson() => _$ConversationToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Member {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'firstName')
  final  String? firstName;
  @JsonKey(name: 'lastName')
  final  String? lastName;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'phone')
  final  String? phone;
  @JsonKey(name: 'image')
  final  String? image;
  @JsonKey(name: 'role')
  final  String? role;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'isWorkspaceAccountConnected')
  final  bool? isWorkspaceAccountConnected;
  @JsonKey(name: 'isPropertyAccountConnected')
  final  bool? isPropertyAccountConnected;

  Member({this.Id, this.firstName, this.lastName, this.email, this.phone, this.image, this.role, this.status, this.isWorkspaceAccountConnected, this.isPropertyAccountConnected});

   factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

   Map<String, dynamic> toJson() => _$MemberToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class LastMessage {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'conversationId')
  final  String? conversationId;
  @JsonKey(name: 'text')
  final  String? text;
  @JsonKey(name: 'senderId')
  final  String? senderId;
  @JsonKey(name: 'media')
  final  Media? media;
  @JsonKey(name: 'createdAt')
  final  String? createdAt;
  @JsonKey(name: 'updatedAt')
  final  String? updatedAt;

  LastMessage({this.Id, this.conversationId, this.text, this.senderId, this.media, this.createdAt, this.updatedAt});

   factory LastMessage.fromJson(Map<String, dynamic> json) => _$LastMessageFromJson(json);

   Map<String, dynamic> toJson() => _$LastMessageToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Media {
  @JsonKey(name: 'url')
  final  String? url;
  @JsonKey(name: 'type')
  final  String? type;

  Media({this.url, this.type});

   factory Media.fromJson(Map<String, dynamic> json) => _$MediaFromJson(json);

   Map<String, dynamic> toJson() => _$MediaToJson(this);
}

