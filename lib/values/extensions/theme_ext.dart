import 'package:homework/core/assets/asset_manager.dart';
import 'package:homework/values/colors.dart';
import 'package:flutter/material.dart';

extension CustomThemeData on ThemeData {
  AssetManager get assets {
    return assetManager;
  }

  AppColor get colors {
    return appColor;
  }
}
