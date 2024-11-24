import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 28.spMin,
              fontWeight: FontWeight.w800,
              color: appColor.primaryColor,
            ),
          ),
          TextSpan(
            text: ' $subtitle',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 12.spMin,
              fontWeight: FontWeight.w400,
              color: appColor.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
