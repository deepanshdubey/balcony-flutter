import 'package:json_annotation/json_annotation.dart';

part 'media_data.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class MediaData {
  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: 'fieldname')
  final String? fieldName;

  MediaData({this.url, this.type, this.fieldName});

  factory MediaData.fromJson(Map<String, dynamic> json) =>
      _$MediaDataFromJson(json);

  Map<String, dynamic> toJson() => _$MediaDataToJson(this);
}
