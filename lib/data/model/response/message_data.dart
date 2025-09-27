import 'package:homework/data/model/response/media_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_data.g.dart';

@JsonSerializable()
class MessageData {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'conversationId')
  final String? conversationId;

  @JsonKey(name: 'text')
  final String? text;

  @JsonKey(name: 'senderId')
  final String? senderId;

  @JsonKey(name: 'media')
  final MediaData? media;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  MessageData({
    this.id,
    this.conversationId,
    this.text,
    this.senderId,
    this.media,
    this.createdAt,
    this.updatedAt,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => _$MessageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MessageDataToJson(this);
}
