import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/generated/assets.dart';

class AssetManager {
  String get splashBg => Assets.imagesSplashBg;
}

final assetManager = locator<AssetManager>();
