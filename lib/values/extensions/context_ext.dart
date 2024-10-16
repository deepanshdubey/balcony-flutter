import 'package:flutter/material.dart';

extension ContextX on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  double get aspectRatio => MediaQuery.of(this).size.aspectRatio;

  Orientation get orientation => MediaQuery.of(this).orientation;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  void hideKeyboard() {
    Focus.of(this).unfocus();
  }
}