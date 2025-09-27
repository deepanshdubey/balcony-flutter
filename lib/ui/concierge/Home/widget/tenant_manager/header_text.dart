import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderText extends StatelessWidget {
  final String title;
  final String subtitle;

  const HeaderText(
      {required this.theme, required this.title, required this.subtitle});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 23.spMin,
                fontWeight: FontWeight.w500,
                color: theme.primaryColor)),
        4.verticalSpace,
        Text(subtitle),
      ],
    );
  }
}
