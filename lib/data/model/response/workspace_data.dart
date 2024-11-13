import 'package:json_annotation/json_annotation.dart';

part 'workspace_data.g.dart';


@JsonSerializable()
class WorkspaceData {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'host')
  final Host host;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'ratings')
  final int ratings;

  @JsonKey(name: 'info')
  final Info info;

  @JsonKey(name: 'images')
  final List<String> images;

  @JsonKey(name: 'geocode')
  final Geocode geocode;

  @JsonKey(name: 'pricing')
  final Pricing pricing;

  @JsonKey(name: 'times')
  final Times times;

  @JsonKey(name: 'other')
  final Other other;

  @JsonKey(name: 'amenities')
  final String amenities;

  WorkspaceData({
    required this.id,
    required this.host,
    required this.status,
    required this.ratings,
    required this.info,
    required this.images,
    required this.geocode,
    required this.pricing,
    required this.times,
    required this.other,
    required this.amenities,
  });

  factory WorkspaceData.fromJson(Map<String, dynamic> json) =>
      _$WorkspaceDataFromJson(json);

  Map<String, dynamic> toJson() => _$WorkspaceDataToJson(this);
}

@JsonSerializable()
class Host {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'firstName')
  final String firstName;

  @JsonKey(name: 'lastName')
  final String lastName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'isWorkspaceAccountConnected')
  final bool isWorkspaceAccountConnected;

  @JsonKey(name: 'isPropertyAccountConnected')
  final bool isPropertyAccountConnected;

  Host({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.image,
    required this.role,
    required this.status,
    required this.isWorkspaceAccountConnected,
    required this.isPropertyAccountConnected,
  });

  factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

  Map<String, dynamic> toJson() => _$HostToJson(this);
}

@JsonSerializable()
class Info {
  final String name;
  final String address;
  final String floor;
  final String city;
  final String state;
  final String country;
  final String summary;

  Info({
    required this.name,
    required this.address,
    required this.floor,
    required this.city,
    required this.state,
    required this.country,
    required this.summary,
  });

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable()
class Geocode {
  final double lat;
  final double lon;

  Geocode({
    required this.lat,
    required this.lon,
  });

  factory Geocode.fromJson(Map<String, dynamic> json) =>
      _$GeocodeFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodeToJson(this);
}

@JsonSerializable()
class Pricing {
  final String currency;
  final int totalPerDay;
  final Fee cleaning;
  final Fee maintenance;
  final Fee additional;

  Pricing({
    required this.currency,
    required this.totalPerDay,
    required this.cleaning,
    required this.maintenance,
    required this.additional,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) =>
      _$PricingFromJson(json);

  Map<String, dynamic> toJson() => _$PricingToJson(this);
}

@JsonSerializable()
class Fee {
  final int fee;
  final String type;

  Fee({
    required this.fee,
    required this.type,
  });

  factory Fee.fromJson(Map<String, dynamic> json) => _$FeeFromJson(json);

  Map<String, dynamic> toJson() => _$FeeToJson(this);
}

@JsonSerializable()
class Times {
  final DayTime sunday;
  final DayTime monday;
  final DayTime tuesday;
  final DayTime wednesday;
  final DayTime thursday;
  final DayTime friday;
  final DayTime saturday;

  Times({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  factory Times.fromJson(Map<String, dynamic> json) =>
      _$TimesFromJson(json);

  Map<String, dynamic> toJson() => _$TimesToJson(this);
}

@JsonSerializable()
class DayTime {
  final String startTime;
  final String endTime;

  DayTime({
    required this.startTime,
    required this.endTime,
  });

  factory DayTime.fromJson(Map<String, dynamic> json) =>
      _$DayTimeFromJson(json);

  Map<String, dynamic> toJson() => _$DayTimeToJson(this);
}

@JsonSerializable()
class Other {
  final bool isIndoorSpace;
  final bool isOutdoorSpace;
  final bool isCoWorkingWorkspace;
  final int additionalGuests;

  Other({
    required this.isIndoorSpace,
    required this.isOutdoorSpace,
    required this.isCoWorkingWorkspace,
    required this.additionalGuests,
  });

  factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);

  Map<String, dynamic> toJson() => _$OtherToJson(this);
}