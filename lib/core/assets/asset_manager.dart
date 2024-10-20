import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/generated/assets.dart';

class AssetManager {
  String get splashBg => Assets.imagesSplashBg;

  String get walkthrough1 => Assets.imagesWalkthrough1;

  String get walkthrough2 => Assets.imagesWalkthrough2;

  String get walkthrough3 => Assets.imagesWalkthrough3;

  String get back => Assets.imagesBack;

  String get startBg => Assets.imagesStartBg;

  String get facebook => Assets.imagesFacebook;

  String get google => Assets.imagesGoogle;

  String get bottomNavigationSearch => Assets.imagesSearch;

  String get bottomNavigationChat => Assets.imagesChat;

  String get bottomNavigationWorks => Assets.imagesWorks;

  String get bottomNavigationStays => Assets.imagesStays;

  String get bottomNavigationMore => Assets.imagesMore;

  String get calender => Assets.imagesCalendar;

  String get beds => Assets.imagesBeds;

  String get baths => Assets.imagesBaths;

  String get ratingStar => Assets.imagesRatingStar;
}

final assetManager = locator<AssetManager>();
