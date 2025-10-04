// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_ticket_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportTicketData _$SupportTicketDataFromJson(Map<String, dynamic> json) =>
    SupportTicketData(
      id: json['_id'] as String?,
      workspace: json['workspace'] == null
          ? null
          : WorkspaceData.fromJson(json['workspace'] as Map<String, dynamic>),
      property: json['property'] == null
          ? null
          : PropertyData.fromJson(json['property'] as Map<String, dynamic>),
      conversation: (json['conversation'] as List<dynamic>?)
          ?.map((e) => Conversation.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$SupportTicketDataToJson(SupportTicketData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'workspace': instance.workspace,
      'property': instance.property,
      'conversation': instance.conversation,
      'status': instance.status,
    };

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
      from: json['from'] as String?,
      context: json['context'] as String?,
      sendOn: json['sendOn'] as String?,
    );

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'from': instance.from,
      'context': instance.context,
      'sendOn': instance.sendOn,
    };
