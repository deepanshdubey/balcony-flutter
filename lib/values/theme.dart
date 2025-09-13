import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/values/colors.dart';

ThemeData createTheme(ColorScheme colors, TextTheme textTheme) {
  return ThemeData(
    colorScheme: colors,
    scaffoldBackgroundColor: appColor.containerColor,
    primaryColor: appColor.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      color: colors.surface,
      iconTheme: IconThemeData(color: colors.primary, size: 30.0),
      toolbarTextStyle: textTheme.bodyMedium,
      titleTextStyle: textTheme.titleLarge,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: colors.primary,
      disabledColor: colors.onPrimary,
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(colors.primary),
      overlayColor: WidgetStateProperty.all(colors.onPrimary),
    ),
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.r),
        borderSide: BorderSide(color: colors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.r),
        borderSide: BorderSide(color: colors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.r),
        borderSide: BorderSide(color: colors.primary),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.r),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    dividerColor: colors.outlineVariant,
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return appColor.primaryColor; // Color when the switch is ON
          }
          return appColor.strokeColor; // Color when the switch is OFF
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return appColor.primaryColor
                .withOpacity(0.5); // Track color when ON
          }
          return appColor.strokeColor.withOpacity(0.3); // Track color when OFF
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.pressed)) {
            return appColor.primaryColor
                .withOpacity(0.2); // Ripple color when pressed
          }
          if (states.contains(MaterialState.hovered)) {
            return appColor.primaryColor.withOpacity(0.1); // Hover effect
          }
          return null; // Default: no overlay
        },
      ),
      splashRadius: 20.0, // Radius for the ripple effect
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all(colors.surface),
        elevation: WidgetStateProperty.all(4),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      headerBackgroundColor: appColor.primaryColor,
      headerForegroundColor: colors.onPrimaryContainer,
      dayStyle: TextStyle(color: colors.onSurface),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return appColor.primaryColor; // When checked
          }
          return Colors.white; // When unchecked
        },
      ),
      checkColor: WidgetStateProperty.all(Colors.white),
      // Optional: Set check mark color
      overlayColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.hovered)) {
            return appColor.primaryColor.withOpacity(0.1);
          } else if (states.contains(WidgetState.pressed)) {
            return appColor.primaryColor.withOpacity(0.2);
          } else if (states.contains(WidgetState.selected)) {
            return appColor.primaryColor.withOpacity(0.3);
          }
          return null;
        },
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      side: BorderSide(color: appColor.primaryColor, width: 1.0),
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
    surface: appColor.backgroundColor,
    onSurface: appColor.textColor,
    outline: appColor.strokeColor,
    outlineVariant: appColor.dividerColor,
  ),
  textTheme,
);
