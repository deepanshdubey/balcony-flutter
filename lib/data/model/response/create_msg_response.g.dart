// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_msg_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateMsgResponse _$CreateMsgResponseFromJson(Map<String, dynamic> json) =>
    CreateMsgResponse(
      success: json['success'] as bool?,
      messageId: json['messageId'] as String?,
      media: json['media'] == null
          ? null
          : Media.fromJson(json['media'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateMsgResponseToJson(CreateMsgResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messageId': instance.messageId,
      'media': instance.media,
    };

Media _$MediaFromJson(Map<String, dynamic> json) => Media(
      url: json['url'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$MediaToJson(Media instance) => <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
    };
