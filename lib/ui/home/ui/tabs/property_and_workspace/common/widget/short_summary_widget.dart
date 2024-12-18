import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortSummaryWidget extends StatelessWidget {
  final bool isWorkspace;

  const ShortSummaryWidget({
    super.key,
    required this.formKey,
    required this.summaryController,
    this.isWorkspace = true,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController summaryController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.25))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            Text(
              isWorkspace ? "short summary about the workspace  ": 'short summary about the property rental',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: summaryController,
              label: '',
              showLabelAboveField: false,
              minLines: 4,
              maxLines: 4,
              hintText: 'Type your message here.',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
