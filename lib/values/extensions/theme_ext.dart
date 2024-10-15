import 'package:balcony/core/assets/asset_manager.dart';
import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';

extension CustomThemeData on ThemeData {
  AssetManager get assets {
    return assetManager;
  }

  AppColor get appColors {
    return appColors;
  }
}
