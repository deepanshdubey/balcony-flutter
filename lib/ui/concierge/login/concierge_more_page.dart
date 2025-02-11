import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/widget/app_image.dart';

class ConciergeMorePage extends StatefulWidget {
  const ConciergeMorePage({super.key});

  @override
  State<ConciergeMorePage> createState() => _ConciergeMorePageState();
}

class _ConciergeMorePageState extends State<ConciergeMorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          20.verticalSpace,
          Padding(
            padding: const EdgeInsets.only(left: 30).r,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12).r,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10.0,
                    ),
                  ]),
              padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 20),
              child: GestureDetector(
                onTap: () {
session.logout();
                  appRouter.replaceAll([const StartRoute()]);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppImage(
                      height: 20.r,
                      width: 20.r,
                      assetPath: Assets.imagesLogout,
                    ),
                    16.w.horizontalSpace,
                    Text(
                      "Log out",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14.spMin,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }



}
