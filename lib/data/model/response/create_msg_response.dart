import 'package:json_annotation/json_annotation.dart'; 

part 'create_msg_response.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class CreateMsgResponse {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'messageId')
  final  String? messageId;
  @JsonKey(name: 'media')
  final  List<Media>? media;

  CreateMsgResponse({this.success, this.messageId, this.media});

   factory CreateMsgResponse.fromJson(Map<String, dynamic> json) => _$CreateMsgResponseFromJson(json);

   Map<String, dynamic> toJson() => _$CreateMsgResponseToJson(this);
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

