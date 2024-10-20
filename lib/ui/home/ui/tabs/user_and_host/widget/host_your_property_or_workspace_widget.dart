import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_outlined_button.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            "host your workspace or property",
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
          Row(
            children: [
              Expanded(
                  child: PrimaryButton(
                text: "sign up workspace",
                onPressed: () {},
              )),
              12.w.horizontalSpace,
              Expanded(
                  child: AppOutlinedButton(
                text: "sign up property",
                onPressed: () {},
              )),
            ],
          ),
          100.h.verticalSpace,
        ],
      ),
    );
  }
}
