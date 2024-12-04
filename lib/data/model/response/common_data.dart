import 'package:balcony/data/model/response/card_data.dart';
import 'package:balcony/data/model/response/conversation_data.dart';
import 'package:balcony/data/model/response/support_ticket_data.dart';
import 'package:balcony/data/model/response/user_data.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bookings_data.dart';

part 'common_data.g.dart';

@JsonSerializable()
class CommonData {
  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'url')
  String? url;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'user')
  UserData? user;
  @JsonKey(name: 'status')
  Map<String, dynamic>? status;

  @JsonKey(name: 'tickets')
  List<SupportTicketData>? tickets;

  @JsonKey(name: 'cards')
  List<CardData>? cards;

  @JsonKey(name: 'bookings')
  List<BookingsData>? bookings;

  @JsonKey(name: 'conversations')
  List<ConversationData>? conversations;

  @JsonKey(name: 'workspaces')
  List<WorkspaceData>? workspaces;

  @JsonKey(name: 'dates')
  List<String>? bookingsDates;

  @JsonKey(name: 'earnings')
  num? earnings;
  @JsonKey(name: 'deposits')
  num? deposits;

  @JsonKey(name: 'messages')
  List<LastMessage>? messages;

  @JsonKey(name: 'messageId')
  final  String? messageId;

  @JsonKey(name: 'media')
  final  Media? media;



  CommonData({this.messageId, this.media,
    this.success,
    this.message,
    this.user,
    this.token,
    this.tickets,
    this.cards,
    this.status,
    this.url,
    this.earnings,
    this.deposits,
    this.bookings,
    this.conversations,
    this.messages,
    this.bookingsDates,
  });

  factory CommonData.fromJson(Map<String, dynamic> json) =>
      _$CommonDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommonDataToJson(this);
}
