import 'package:auto_route/auto_route.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/int_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(
      2.seconds,
      () {
        if (session.isWalkthroughSeen) {
          if (session.isLogin || session.isLoginSkipped) {
            appRouter.replaceAll([const HomeRoute()]);
          } else {
            appRouter.replaceAll([const StartRoute()]);
          }
        } else {
          appRouter.replaceAll([const WalkthroughRoute()]);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          AppImage(
            width: context.width,
            height: context.height,
            assetPath: theme.assets.splashBg,
            alignment: Alignment.topCenter,
            boxFit: BoxFit.fitWidth,
          ),
          Positioned(
            left: 24.w,
            top: context.height * .3,
            child: Text(
              "homework",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 30.spMin,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}
