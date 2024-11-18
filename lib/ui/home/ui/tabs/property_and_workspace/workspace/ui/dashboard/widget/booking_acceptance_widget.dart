import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingAcceptanceWidget extends StatefulWidget {
  const BookingAcceptanceWidget({super.key});

  @override
  State<BookingAcceptanceWidget> createState() => _BookingAcceptanceWidgetState();
}

class _BookingAcceptanceWidgetState extends State<BookingAcceptanceWidget> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'booking acceptance',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Text(
            "you can automatically accept bookings as they come in or you may also manually accept orders as well.",
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w300,
              color: theme.primaryColor,
            ),
          ),
          16.h.verticalSpace,
          tabBar(theme),

        ],
      ),
    );
  }
  Widget tabBar(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(color: Colors.black.withOpacity(.25))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTab(theme, "manually", 0),
            _buildTab(theme, "automatically", 1),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(ThemeData theme, String text, int index) {
    bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
            color: isActive ? theme.colors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(12.r))),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 16.spMin,
            fontWeight: FontWeight.w500,
            color: _currentIndex == index
                ? theme.colors.backgroundColor
                : theme.colors.primaryColor,
          ),
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
