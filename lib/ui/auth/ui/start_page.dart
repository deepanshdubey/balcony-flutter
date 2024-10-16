import 'package:auto_route/auto_route.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_outlined_button.dart';
import 'package:balcony/widget/primary_button.dart';
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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AppImage(
            width: context.width,
            height: context.height,
            assetPath: theme.assets.startBg,
          ),
          Positioned(
            left: 24.w,
            top: context.height * .3,
            child: Text(
              "balcony",
              style: theme.textTheme.titleLarge?.copyWith(
                fontSize: 48.spMin,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          SafeArea(
            child: Row(
              children: [
                20.w.horizontalSpace,
                Expanded(
                    child: AppOutlinedButton(
                  text: "just visiting",
                  onPressed: () {},
                )),
                12.w.horizontalSpace,
                Expanded(
                    child: PrimaryButton(
                  text: "sign up",
                  onPressed: () {},
                )),
                20.w.horizontalSpace,
              ],
            ),
          )
        ],
      ),
    );
  }
}
