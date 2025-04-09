import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/concierge/login/concierge_more_page.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/chat_page.dart';
import 'package:homework/values/extensions/theme_ext.dart';

class ConciergeHeader extends StatelessWidget {
  const ConciergeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius
                .circular(12)
                .r,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20.0,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15).r,
          child: Row(
            children: [
              20.horizontalSpace,
              Text(
                "homework",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20.spMin,
                  fontWeight: FontWeight.w700,
                ),
              ),
              10.horizontalSpace,
              const Spacer(),
              GestureDetector(
                onTap: () {
                  showAppBottomSheet(
                    context,
                    const ConciergeMorePage(),
                  );
                },
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                  decoration: BoxDecoration(
                      border: Border.all(color: theme.colors.grayBorder),
                      borderRadius: BorderRadius.all(Radius.circular(12.r))),
                  child: Image.asset(
                    Assets.imagesProfile,
                    height: 15.r,
                    width: 15.r,
                  ),
                ),
              ),
              20.horizontalSpace,
            ],
          ),
        ));
  }
}
