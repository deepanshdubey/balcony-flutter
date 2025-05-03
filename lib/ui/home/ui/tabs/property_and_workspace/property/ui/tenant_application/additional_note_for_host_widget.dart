import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_text_field.dart';

class AdditionalNoteForHostWidget extends StatelessWidget {
  const AdditionalNoteForHostWidget({
    required this.noteController,
  });

  final TextEditingController noteController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: GlobalKey(),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(
                color: Theme.of(context).primaryColor.withAlpha(60))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            Text(
              "additional notes for host's review if applicable",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: noteController,
              label: '',
              showLabelAboveField: false,
              minLines: 4,
              maxLines: 4,
              hintText: 'type your message here.',
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
