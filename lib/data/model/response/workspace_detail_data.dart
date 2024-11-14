import 'package:json_annotation/json_annotation.dart'; 

part 'workspace_detail_data.g.dart'; 

@JsonSerializable(ignoreUnannotated: true)
class WorkspaceDetailData {
  @JsonKey(name: 'success')
  final  bool? success;
  @JsonKey(name: 'data')
  final  Data? data;

  WorkspaceDetailData({this.success, this.data});

   factory WorkspaceDetailData.fromJson(Map<String, dynamic> json) => _$WorkspaceDetailDataFromJson(json);

   Map<String, dynamic> toJson() => _$WorkspaceDetailDataToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Data {
  @JsonKey(name: 'count')
  final  int? count;
  @JsonKey(name: 'items')
  final  List<Item>? items;

  Data({this.count, this.items});

   factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

   Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Item {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'host')
  final  Host? host;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'ratings')
  final  int? ratings;
  @JsonKey(name: 'info')
  final  Info? info;
  @JsonKey(name: 'images')
  final  List<String>? images;
  @JsonKey(name: 'geocode')
  final  Geocode? geocode;
  @JsonKey(name: 'pricing')
  final  Pricing? pricing;
  @JsonKey(name: 'times')
  final  Times? times;
  @JsonKey(name: 'other')
  final  Other? other;
  @JsonKey(name: 'amenities')
  final  String? amenities;
  @JsonKey(name: 'bookedDates')
  final  List<String>? bookedDates;

  Item({this.Id, this.host, this.status, this.ratings, this.info, this.images, this.geocode, this.pricing, this.times, this.other, this.amenities, this.bookedDates});

   factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

   Map<String, dynamic> toJson() => _$ItemToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Host {
  @JsonKey(name: '_id')
  final  String? Id;
  @JsonKey(name: 'firstName')
  final  String? firstName;
  @JsonKey(name: 'lastName')
  final  String? lastName;
  @JsonKey(name: 'email')
  final  String? email;
  @JsonKey(name: 'phone')
  final  String? phone;
  @JsonKey(name: 'image')
  final  String? image;
  @JsonKey(name: 'role')
  final  String? role;
  @JsonKey(name: 'status')
  final  String? status;
  @JsonKey(name: 'isWorkspaceAccountConnected')
  final  bool? isWorkspaceAccountConnected;
  @JsonKey(name: 'isPropertyAccountConnected')
  final  bool? isPropertyAccountConnected;

  Host({this.Id, this.firstName, this.lastName, this.email, this.phone, this.image, this.role, this.status, this.isWorkspaceAccountConnected, this.isPropertyAccountConnected});

   factory Host.fromJson(Map<String, dynamic> json) => _$HostFromJson(json);

   Map<String, dynamic> toJson() => _$HostToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Info {
  @JsonKey(name: 'name')
  final  String? name;
  @JsonKey(name: 'address')
  final  String? address;
  @JsonKey(name: 'floor')
  final  String? floor;
  @JsonKey(name: 'city')
  final  String? city;
  @JsonKey(name: 'state')
  final  String? state;
  @JsonKey(name: 'country')
  final  String? country;
  @JsonKey(name: 'summary')
  final  String? summary;

  Info({this.name, this.address, this.floor, this.city, this.state, this.country, this.summary});

   factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

   Map<String, dynamic> toJson() => _$InfoToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Geocode {
  @JsonKey(name: 'lat')
  final  double? lat;
  @JsonKey(name: 'lon')
  final  double? lon;

  Geocode({this.lat, this.lon});

   factory Geocode.fromJson(Map<String, dynamic> json) => _$GeocodeFromJson(json);

   Map<String, dynamic> toJson() => _$GeocodeToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Pricing {
  @JsonKey(name: 'currency')
  final  String? currency;
  @JsonKey(name: 'totalPerDay')
  final  int? totalPerDay;
  @JsonKey(name: 'cleaning')
  final  Cleaning? cleaning;
  @JsonKey(name: 'maintenance')
  final  Maintenance? maintenance;
  @JsonKey(name: 'additional')
  final  Additional? additional;

  Pricing({this.currency, this.totalPerDay, this.cleaning, this.maintenance, this.additional});

   factory Pricing.fromJson(Map<String, dynamic> json) => _$PricingFromJson(json);

   Map<String, dynamic> toJson() => _$PricingToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Cleaning {
  @JsonKey(name: 'fee')
  final  int? fee;
  @JsonKey(name: 'type')
  final  String? type;

  Cleaning({this.fee, this.type});

   factory Cleaning.fromJson(Map<String, dynamic> json) => _$CleaningFromJson(json);

   Map<String, dynamic> toJson() => _$CleaningToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Maintenance {
  @JsonKey(name: 'fee')
  final  int? fee;
  @JsonKey(name: 'type')
  final  String? type;

  Maintenance({this.fee, this.type});

   factory Maintenance.fromJson(Map<String, dynamic> json) => _$MaintenanceFromJson(json);

   Map<String, dynamic> toJson() => _$MaintenanceToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Additional {
  @JsonKey(name: 'fee')
  final  int? fee;
  @JsonKey(name: 'type')
  final  String? type;

  Additional({this.fee, this.type});

   factory Additional.fromJson(Map<String, dynamic> json) => _$AdditionalFromJson(json);

   Map<String, dynamic> toJson() => _$AdditionalToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Times {
  @JsonKey(name: 'sunday')
  final  Sunday? sunday;
  @JsonKey(name: 'monday')
  final  Monday? monday;
  @JsonKey(name: 'tuesday')
  final  Tuesday? tuesday;
  @JsonKey(name: 'wednesday')
  final  Wednesday? wednesday;
  @JsonKey(name: 'thursday')
  final  Thursday? thursday;
  @JsonKey(name: 'friday')
  final  Friday? friday;
  @JsonKey(name: 'saturday')
  final  Saturday? saturday;

  Times({this.sunday, this.monday, this.tuesday, this.wednesday, this.thursday, this.friday, this.saturday});

   factory Times.fromJson(Map<String, dynamic> json) => _$TimesFromJson(json);

   Map<String, dynamic> toJson() => _$TimesToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Sunday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Sunday({this.startTime, this.endTime});

   factory Sunday.fromJson(Map<String, dynamic> json) => _$SundayFromJson(json);

   Map<String, dynamic> toJson() => _$SundayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Monday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Monday({this.startTime, this.endTime});

   factory Monday.fromJson(Map<String, dynamic> json) => _$MondayFromJson(json);

   Map<String, dynamic> toJson() => _$MondayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Tuesday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Tuesday({this.startTime, this.endTime});

   factory Tuesday.fromJson(Map<String, dynamic> json) => _$TuesdayFromJson(json);

   Map<String, dynamic> toJson() => _$TuesdayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Wednesday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Wednesday({this.startTime, this.endTime});

   factory Wednesday.fromJson(Map<String, dynamic> json) => _$WednesdayFromJson(json);

   Map<String, dynamic> toJson() => _$WednesdayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Thursday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Thursday({this.startTime, this.endTime});

   factory Thursday.fromJson(Map<String, dynamic> json) => _$ThursdayFromJson(json);

   Map<String, dynamic> toJson() => _$ThursdayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Friday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Friday({this.startTime, this.endTime});

   factory Friday.fromJson(Map<String, dynamic> json) => _$FridayFromJson(json);

   Map<String, dynamic> toJson() => _$FridayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Saturday {
  @JsonKey(name: 'startTime')
  final  String? startTime;
  @JsonKey(name: 'endTime')
  final  String? endTime;

  Saturday({this.startTime, this.endTime});

   factory Saturday.fromJson(Map<String, dynamic> json) => _$SaturdayFromJson(json);

   Map<String, dynamic> toJson() => _$SaturdayToJson(this);
}

@JsonSerializable(ignoreUnannotated: true)
class Other {
  @JsonKey(name: 'isIndoorSpace')
  final  bool? isIndoorSpace;
  @JsonKey(name: 'isOutdoorSpace')
  final  bool? isOutdoorSpace;
  @JsonKey(name: 'isCoWorkingWorkspace')
  final  bool? isCoWorkingWorkspace;
  @JsonKey(name: 'additionalGuests')
  final  int? additionalGuests;

  Other({this.isIndoorSpace, this.isOutdoorSpace, this.isCoWorkingWorkspace, this.additionalGuests});

   factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);

   Map<String, dynamic> toJson() => _$OtherToJson(this);
}

