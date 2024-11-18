import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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


void showAppBottomSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height:  0.8.sh, // Adjusts height to 80% of screen
      padding: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20.r), // Use .r if ScreenUtil is initialized
        ),
      ),
      child: child,
    ),
  );
}
