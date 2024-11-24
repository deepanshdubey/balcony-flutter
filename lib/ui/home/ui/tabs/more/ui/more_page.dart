import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/ui/auth/store/auth_store.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/profile/ui/edit_profile_page.dart';
import 'package:balcony/ui/home/ui/tabs/more/ui/support_tickets/ui/support_tickets_page.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

const hostMap = {
  "profile": Assets.imagesProfile,
  "logout": Assets.imagesLogout,
};

const userMap = {
  "profile": Assets.imagesProfile,
  "wallet": Assets.imagesWallet,
  "support": Assets.imagesSupport,
  "logout": Assets.imagesLogout,
};

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  int _currentIndex = 0;
  List<ReactionDisposer>? disposers;
  final authStore = AuthStore();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.logoutResponse, (response) {
        if (response != null) {
          session.logout();
          appRouter.replaceAll([const SplashRoute()]);
        }
      }),
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var isLoading = authStore.isLoading;
      return LoadingWidget(
        status: isLoading,
        child: ListView(
          children: [
            12.h.verticalSpace,
            tabBar(theme),
            20.h.verticalSpace,
            Container(
              width: context.width,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  border: Border.all(color: Colors.black.withOpacity(.25))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: (_currentIndex == 0 ? userMap : hostMap)
                    .entries
                    .map((entry) {
                  return listItem(theme, entry.key, entry.value);
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget listItem(ThemeData theme, String name, String image) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: GestureDetector(
        onTap: () {
          handleNavigation(name);
        },
        child: Row(
          children: [
            AppImage(
              height: 20.r,
              width: 20.r,
              assetPath: image,
            ),
            16.w.horizontalSpace,
            Text(
              name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabBar(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12.r)),
              border: Border.all(color: Colors.black.withOpacity(.25))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTab(theme, "user", 0),
              _buildTab(theme, "host", 1),
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

  void handleNavigation(String name) {
    switch (name) {
      case 'profile':
        {
          showAppBottomSheet(context, EditProfilePage());
          break;
        }

      case 'support':
        {
          showAppBottomSheet(context, SupportTicketsPage());
          break;
        }
      case 'logout':
        {
          alertManager.showSystemAlertDialog(
            context: context,
            title: 'balcony',
            message: "are you sure want to logout",
            confirmButtonText: 'logout',
            onConfirm: () {
              authStore.logout();
            },
          );
          break;
        }
      default:
        {
          alertManager.showError(context, "Coming Soon");
        }
    }
  }
}
