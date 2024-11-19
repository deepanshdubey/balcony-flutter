import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BorderButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const BorderButton({
    required this.label,
    required this.onTap,
    super.key, this.height, this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 40.h,
        padding:padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.spMin,
            ),
          ),
        ),
      ),
    );
  }
}