import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/int_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
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
          if (session.isLogin) {

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
          ),
          Positioned(
            left: 24.w,
            top: context.height * .3,
            child: Text(
              "balcony",
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
