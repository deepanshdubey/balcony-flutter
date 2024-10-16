import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/generated/assets.dart';

class AssetManager {
  String get splashBg => Assets.imagesSplashBg;

  String get walkthrough1 => Assets.imagesWalkthrough1;

  String get walkthrough2 => Assets.imagesWalkthrough2;

  String get walkthrough3 => Assets.imagesWalkthrough3;

  String get back => Assets.imagesBack;

  String get startBg => Assets.imagesStartBg;
}

final assetManager = locator<AssetManager>();
