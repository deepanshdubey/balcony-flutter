import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppOutlinedButton extends StatelessWidget {
  final String? icon;
  final String text;
  final VoidCallback onPressed;
  final double? iconSize;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final TextStyle? style;

  const AppOutlinedButton({
    super.key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.iconSize,
    this.borderColor,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        backgroundColor: backgroundColor ?? Colors.transparent,
        side: BorderSide(
            color: borderColor ?? Theme.of(context).colors.primaryColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            AppImage(
              assetPath: icon,
              width: iconSize ?? 18.r,
              height: iconSize ?? 18.r,
            ),
          if (icon != null) SizedBox(width: 12.w),
          Flexible(
            child: Text(
              text,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style ??
                  Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 14.spMin,

                    fontWeight: FontWeight.w500,
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
