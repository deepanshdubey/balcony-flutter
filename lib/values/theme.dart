import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData createTheme(ColorScheme colors, TextTheme textTheme) {
  return ThemeData(
    colorScheme: colors,
    scaffoldBackgroundColor: appColor.containerColor,
    primaryColor: appColor.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      color: colors.background,
      iconTheme: IconThemeData(color: colors.primary, size: 30.0),
      toolbarTextStyle: textTheme.bodyMedium,
      titleTextStyle: textTheme.titleLarge,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: colors.primary,
      disabledColor: colors.onPrimary,
    ),
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: colors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
    dividerColor: colors.outlineVariant,
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: MaterialStateProperty.all(colors.background),
        elevation: MaterialStateProperty.all(4),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: colors.primaryContainer,
      headerForegroundColor: colors.onPrimaryContainer,
      dayStyle: TextStyle(color: colors.onSurface),
    ),
  );
}

final TextTheme textTheme = TextTheme(
  titleLarge: TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.bold,
    color: appColor.textColor,
    fontSize: 16.spMin,
  ),
  titleMedium: TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    color: appColor.textColor,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    color: appColor.textColor,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.normal,
    color: appColor.subtitleColor,
    fontSize: 14.spMin,
  ),
  bodySmall: TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w300,
    color: appColor.textColor,
  ),
);

final ThemeData appTheme = createTheme(
  ColorScheme.fromSwatch().copyWith(
    primary: appColor.primaryColor,
    secondary: appColor.iconColor,
    background: appColor.backgroundColor,
    surface: appColor.fillColor,
    onSurface: appColor.textColor,
    outline: appColor.strokeColor,
    outlineVariant: appColor.dividerColor,
  ),
  textTheme,
);
