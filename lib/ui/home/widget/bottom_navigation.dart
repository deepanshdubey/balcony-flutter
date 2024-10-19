import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigation extends StatefulWidget {
  final Function(String) onItemSelected;

  const BottomNavigation({super.key, required this.onItemSelected});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  bool isUserSelected = true;
  String previousItem = "user";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        width: context.width,
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.25),
              offset: const Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            switchHostUser(theme),
            bottomTab(theme, "search", theme.assets.bottomNavigationSearch),
            bottomTab(theme, "chat", theme.assets.bottomNavigationChat),
            bottomTab(theme, "works", theme.assets.bottomNavigationWorks),
            bottomTab(theme, "stays", theme.assets.bottomNavigationStays),
            bottomTab(theme, "more", theme.assets.bottomNavigationMore),
          ],
        ),
      ),
    );
  }

  Widget switchHostUser(ThemeData theme) {
    return GestureDetector(
      onTap: () {
        if (previousItem == 'user' || previousItem == 'host') {
          setState(() {
            isUserSelected = !isUserSelected;
          });
        }
        previousItem = isUserSelected ? "user" : "host";
        widget.onItemSelected(isUserSelected ? "user" : "host");
      },
      child: Container(
        width: 54.w,
        height: 47.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.solid,
              color: Colors.black.withOpacity(.25),
              offset: const Offset(0, 0),
              blurRadius: 3,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            tab(theme, "user", isUserSelected),
            2.h.verticalSpace,
            tab(theme, "host", !isUserSelected),
          ],
        ),
      ),
    );
  }

  Widget tab(ThemeData theme, String text, bool isSelected) {
    return isSelected
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: theme.colors.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontSize: 12.spMin,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        : Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontSize: 12.spMin,
              fontWeight: FontWeight.w500,
            ),
          );
  }

  Widget bottomTab(ThemeData theme, String text, String icon) {
    return GestureDetector(
      onTap: () {
        previousItem = text;
        widget.onItemSelected(text);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImage(
            assetPath: icon,
            height: 30.r,
            width: 30.r,
          ),
          6.h.verticalSpace,
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.primaryColor,
              fontSize: 12.spMin,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
