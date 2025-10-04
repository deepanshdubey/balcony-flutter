// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageData _$MessageDataFromJson(Map<String, dynamic> json) => MessageData(
      id: json['_id'] as String?,
      conversationId: json['conversationId'] as String?,
      text: json['text'] as String?,
      senderId: json['senderId'] as String?,
      media: json['media'] == null
          ? null
          : MediaData.fromJson(json['media'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MessageDataToJson(MessageData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'conversationId': instance.conversationId,
      'text': instance.text,
      'senderId': instance.senderId,
      'media': instance.media,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
