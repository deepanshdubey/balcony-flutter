import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/auth/ui/bottomsheet/onboarding_bottomsheet.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/primary_button.dart';

class HostYourPropertyOrWorkspaceWidget extends StatelessWidget {
  const HostYourPropertyOrWorkspaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppImage(
            assetPath: theme.assets.hostYourPropertyOrWorkspace,
            width: context.width - 40.w,
            height: context.width - 40.w,
            boxFit: BoxFit.cover,
          ),
          32.h.verticalSpace,
          Text(
            "host your workspace",
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 34.spMin,
              fontWeight: FontWeight.w600,
            ),
          ),
          16.h.verticalSpace,
          Text(
            "indoor and outdoor",
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 14.spMin,
              fontWeight: FontWeight.w500,
            ),
          ),
          3.h.verticalSpace,
          Text(
            "let people discover your workspace on our platform",
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 14.spMin,
              fontWeight: FontWeight.normal,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            color: theme.primaryColor,
            height: 1.h,
            width: context.width * .7,
          ),
          Row(
            children: [
              Text(
                "learn",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                color: theme.dividerColor,
                height: 24.h,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              Text(
                "work",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                color: theme.dividerColor,
                height: 24.h,
                width: 1,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
              ),
              Text(
                "collaborate",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 14.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          20.h.verticalSpace,
          PrimaryButton(
            text: "sign up workspace",
            onPressed: () {
              if (session.isLogin) {
                navigateToCreateWorkSpace(context);
              } else {
                showOnboardingBottomSheet(
                  context,
                  onSuccess: () {
                    navigateToCreateWorkSpace(context);
                  },
                );
              }
            },
          ),
          100.h.verticalSpace,
        ],
      ),
    );
  }

  void navigateToCreateWorkSpace(BuildContext context) {
    appRouter.push(CreateWorkspaceRoute());
  }

  void navigateToCreateProperty(BuildContext context) {
    appRouter.push(const PlansRoute());
  }
}
