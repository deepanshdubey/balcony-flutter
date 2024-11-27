import 'package:balcony/data/model/response/card_data.dart';
import 'package:balcony/data/model/response/support_ticket_data.dart';
import 'package:balcony/data/model/response/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bookings_data.dart';

part 'common_data.g.dart';

@JsonSerializable()
class CommonData {
  @JsonKey(name: "success")
  bool? success;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'token')
  String? token;

  @JsonKey(name: 'user')
  UserData? user;

  @JsonKey(name: 'tickets')
  List<SupportTicketData>? tickets;

  @JsonKey(name: 'cards')
  List<CardData>? cards;

  @JsonKey(name: 'bookings')
  List<BookingsData>? bookings;



  CommonData({
    this.success,
    this.message,
    this.user,
    this.token,
    this.tickets,
    this.cards,
  });

  factory CommonData.fromJson(Map<String, dynamic> json) =>
      _$CommonDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommonDataToJson(this);
}
