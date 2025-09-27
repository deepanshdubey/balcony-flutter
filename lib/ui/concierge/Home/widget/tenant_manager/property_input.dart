import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/widget/app_text_field.dart';

class PropertyInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;

  const PropertyInput(
      {super.key, required this.controller, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: controller,
          label: 'add property',
          hintText: 'property name..',
        ),
        18.verticalSpace,
        GestureDetector(
          onTap: onAdd,
          child: Row(
            children: [
              Image.asset(Assets.imagesAdd, height: 24.r, width: 24.r),
              6.horizontalSpace,
              Text("add to dropdown",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13.spMin,
                      fontWeight: FontWeight.w500,
                      color: theme.primaryColor))
            ],
          ),
        )
      ],
    );
  }
}
