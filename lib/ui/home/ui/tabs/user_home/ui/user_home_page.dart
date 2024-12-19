import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/auth/ui/sign_in_page.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/widget/property_home_widget.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/store/dashboard_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/widget/workspace_home_widget.dart';
import 'package:homework/ui/home/ui/tabs/user_home/widget/host_your_property_or_workspace_widget.dart';
import 'package:homework/ui/home/ui/tabs/user_home/widget/search_properties_widget.dart';
import 'package:homework/ui/home/ui/tabs/user_home/widget/search_workspaces_widget.dart';
import 'package:homework/ui/home/widget/logout_alert.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _currentIndex = 0;
  var store = DashboardStore();
  List<ReactionDisposer>? disposers;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    store.getReAuthenticate();
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.reAuthenticateResponse, (response) {
        if (response?.success == false) {
          session.isLogin = false;
          showLogoutAlert(context);
        }
      }),
    ];
  }

  void showLogoutAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return LogoutAlertWidget(
          onLoginPressed: () {
            // Close the dialog first
            Navigator.of(dialogContext).pop();
            showAppBottomSheet(
              context,
              SignInPage(
                onSuccess: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
              ),
            );
          },
          onCancelPressed: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
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
}
