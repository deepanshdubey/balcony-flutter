import 'package:balcony/ui/home/ui/tabs/property/widget/property_home_widget.dart';
import 'package:balcony/ui/home/ui/tabs/user_and_host/widget/host_your_property_or_workspace_widget.dart';
import 'package:balcony/ui/home/ui/tabs/user_and_host/widget/search_properties_widget.dart';
import 'package:balcony/ui/home/ui/tabs/user_and_host/widget/search_workspaces_widget.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/widget/workspace_home_widget.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAndHostPage extends StatefulWidget {
  final Function(String) onItemSelected;
  final bool isUserSelected;

  const UserAndHostPage(
      {super.key, required this.isUserSelected, required this.onItemSelected});

  @override
  State<UserAndHostPage> createState() => _UserAndHostPageState();
}

class _UserAndHostPageState extends State<UserAndHostPage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: ListView(
        children: [
          12.h.verticalSpace,
          tabBar(theme),
          10.h.verticalSpace,
          _currentIndex == 0
              ? const SearchWorkspacesWidget()
              : const SearchPropertiesWidget(),
          20.h.verticalSpace,
          const PropertyHomeWidget(),
          const WorkspaceHomeWidget(),
          12.h.verticalSpace,
          const HostYourPropertyOrWorkspaceWidget(),
        ],
      ),
    );
  }

  Widget tabBar(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        24.h.horizontalSpace,
        AppImage(
          assetPath: theme.assets.bottomNavigationSearch,
          height: 30.r,
          width: 30.r,
        ),
        8.w.horizontalSpace,
        Text(
          "search",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.primaryColor,
            fontSize: 16.spMin,
            fontWeight: FontWeight.w500,
          ),
        ),
        10.w.horizontalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTab(theme, "workspace", 0),
              _buildTab(theme, "properties", 1),
            ],
          ),
        ),
      ],
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
}
