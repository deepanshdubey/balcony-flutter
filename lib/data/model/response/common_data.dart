import 'package:balcony/data/model/response/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

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

  CommonData({
    this.success,
    this.message,
    this.user,
    this.token,
  });

  factory CommonData.fromJson(Map<String, dynamic> json) =>
      _$CommonDataFromJson(json);

  Map<String, dynamic> toJson() => _$CommonDataToJson(this);
}
