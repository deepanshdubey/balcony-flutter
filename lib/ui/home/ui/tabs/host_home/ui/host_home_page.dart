import 'package:auto_route/annotations.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/dashboard/ui/property_dashboard_page.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/ui/workspace_dashboard_page.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HostHomePage extends StatefulWidget {
  const HostHomePage({super.key});

  @override
  State<HostHomePage> createState() => _HostHomePageState();
}

class _HostHomePageState extends State<HostHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 0.h),
        children: [
          12.h.verticalSpace,
          if(session.prop)  tabBar(theme),
          if(session.prop)    Container(
            height: 1.h,
            color: theme.primaryColor,
            margin: EdgeInsets.symmetric(vertical: 20.h),
          ),
          _currentIndex == 0
              ? const WorkspaceDashboardPage()
              : const PropertyDashboardPage(),
          20.h.verticalSpace,
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
            _buildTab(theme, "commercial", 0),
            _buildTab(theme, "residential", 1),
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
