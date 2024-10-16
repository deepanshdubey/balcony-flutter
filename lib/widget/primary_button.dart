import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading, enabled;
  final Color? backgroundColor;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.enabled = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      ),
      child: isLoading
          ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(enabled ? 1 : 0.5),
                strokeWidth: 2.r,
              ),
            )
          : Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 15.spMin),
            ),
    );
  }
}
