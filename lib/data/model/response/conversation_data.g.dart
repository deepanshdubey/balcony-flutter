// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationData _$ConversationDataFromJson(Map<String, dynamic> json) =>
    ConversationData(
      Id: json['_id'] as String?,
      host: json['host'] == null
          ? null
          : UserData.fromJson(json['host'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageData.fromJson(json['lastMessage'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      seen: json['seen'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ConversationDataToJson(ConversationData instance) =>
    <String, dynamic>{
      '_id': instance.Id,
      'host': instance.host,
      'user': instance.user,
      'lastMessage': instance.lastMessage,
      'seen': instance.seen,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
