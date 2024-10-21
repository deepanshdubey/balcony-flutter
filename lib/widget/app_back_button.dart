import 'package:balcony/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;

  const AppBackButton({
    super.key,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap ??
          () {
            appRouter.back();
          },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: text == null ? 8.w : 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(12), // For rounded corners
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.arrow_back, color: theme.primaryColor),
            if(text != null) 8.w.horizontalSpace,
            text == null
                ? const SizedBox.shrink()
                : Text(
                    text!,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.spMin,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
