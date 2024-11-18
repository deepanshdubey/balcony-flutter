import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSelected;
  final bool isLoading;
  final Color? backgroundColor;

  const PlanButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.isSelected,
    this.isLoading = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: isSelected
            ? Colors.transparent // Transparent for outlined button
            : (backgroundColor ?? Theme.of(context).primaryColor),
        side: isSelected
            ? BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        )
            : null, // No border for filled button
        elevation: isSelected ? 0 : 2, // Remove shadow for outlined button
      ),
      child: isLoading
          ? SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          color: Theme.of(context)
              .primaryColor
              .withOpacity(isSelected ? 1 : 0.5),
          strokeWidth: 2.r,
        ),
      )
          : Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w500,
            color: isSelected
                ? Theme.of(context).primaryColor // Text for outlined button
                : Colors.white, // Text for filled button
            fontSize: 14.spMin),
      ),
    );
  }
}
