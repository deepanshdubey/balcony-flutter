// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonData _$CommonDataFromJson(Map<String, dynamic> json) => CommonData(
      (json['tenants'] as List<dynamic>?)
          ?.map((e) => Tenants.fromJson(e as Map<String, dynamic>))
          .toList(),
      messageId: json['messageId'] as String?,
      media: json['media'] == null
          ? null
          : MediaData.fromJson(json['media'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
      tickets: (json['tickets'] as List<dynamic>?)
          ?.map((e) => SupportTicketData.fromJson(e as Map<String, dynamic>))
          .toList(),
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => CardData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as Map<String, dynamic>?,
      url: json['url'] as String?,
      earnings: json['earnings'] as num?,
      deposits: json['deposits'] as num?,
      bookings: (json['bookings'] as List<dynamic>?)
          ?.map((e) => BookingsData.fromJson(e as Map<String, dynamic>))
          .toList(),
      conversations: (json['conversations'] as List<dynamic>?)
          ?.map((e) => ConversationData.fromJson(e as Map<String, dynamic>))
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookingsDates:
          (json['dates'] as List<dynamic>?)?.map((e) => e as String).toList(),
      booking: json['booking'] == null
          ? null
          : BookingsData.fromJson(json['booking'] as Map<String, dynamic>),
      urls: (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
      properties: (json['properties'] as List<dynamic>?)
          ?.map((e) => PropertyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      signedUrl: json['signedUrl'] as String?,
      publicUrl: json['publicUrl'] as String?,
      conversation: json['conversation'] == null
          ? null
          : ConversationData.fromJson(
              json['conversation'] as Map<String, dynamic>),
      applicationFee: json['applicationFee'] as num?,
      tenant: json['tenant'] == null
          ? null
          : Tenants.fromJson(json['tenant'] as Map<String, dynamic>),
      verification: json['verification'] == null
          ? null
          : Verification.fromJson(json['verification'] as Map<String, dynamic>),
    )..workspaces = (json['workspaces'] as List<dynamic>?)
        ?.map((e) => WorkspaceData.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$CommonDataToJson(CommonData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'url': instance.url,
      'signedUrl': instance.signedUrl,
      'publicUrl': instance.publicUrl,
      'token': instance.token,
      'user': instance.user,
      'status': instance.status,
      'tickets': instance.tickets,
      'cards': instance.cards,
      'bookings': instance.bookings,
      'booking': instance.booking,
      'conversations': instance.conversations,
      'workspaces': instance.workspaces,
      'properties': instance.properties,
      'dates': instance.bookingsDates,
      'urls': instance.urls,
      'earnings': instance.earnings,
      'deposits': instance.deposits,
      'messages': instance.messages,
      'messageId': instance.messageId,
      'media': instance.media,
      'tenants': instance.tenants,
      'tenant': instance.tenant,
      'applicationFee': instance.applicationFee,
      'verification': instance.verification,
      'conversation': instance.conversation,
    };
