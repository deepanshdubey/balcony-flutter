import 'package:auto_route/auto_route.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/auth/ui/bottomsheet/onboarding_bottomsheet.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Row(
            children: [
              Expanded(
                  child: AppOutlinedButton(
                text: "just visiting",
                onPressed: () {
                  session.isLoginSkipped = true;
                  appRouter.replaceAll([const HomeRoute()]);
                },
              )),
              12.w.horizontalSpace,
              Expanded(
                  child: PrimaryButton(
                text: "sign up",
                onPressed: () {
                  showOnboardingBottomSheet(context);
                },
              )),
            ],
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AppImage(
            width: context.width,
            height: context.height,
            boxFit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
            assetPath: theme.assets.startBg,
          ),
          Positioned(
            left: 24.w,
            top: context.height * .3,
            child: Text(
              "homework",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 48.spMin,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
