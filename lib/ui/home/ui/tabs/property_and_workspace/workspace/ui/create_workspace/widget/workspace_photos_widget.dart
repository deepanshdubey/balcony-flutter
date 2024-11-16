import 'dart:io';

import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class WorkspacePhotosWidget extends StatefulWidget {
  const WorkspacePhotosWidget({super.key});

  @override
  State<WorkspacePhotosWidget> createState() => WorkspacePhotosWidgetState();
}

class WorkspacePhotosWidgetState extends BaseState<WorkspacePhotosWidget> {
  List<String?> userSelectedImages = List.generate(
    3,
    (index) => null,
  );

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(color: theme.primaryColor.withOpacity(.25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.h.verticalSpace,
          Text(
            "property photos*",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
          ),
          16.h.verticalSpace,
          workspacePicker(0),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: workspacePicker(1),
              ),
              6.w.horizontalSpace,
              Expanded(
                child: workspacePicker(2),
              ),
            ],
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  Widget workspacePicker(int index) {
    return Stack(
      children: [
        Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          child: userSelectedImages[index] != null
              ? AppImage(
                  height: double.infinity,
                  width: double.infinity,
                  radius: 12.r,
                  boxFit: BoxFit.cover,
                  file: userSelectedImages[index],
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
            right: 8.r,
            bottom: 8.r,
            child: ImagePickerWidget(
              onImageSelected: (selectedImage) {
                setState(() {
                  userSelectedImages[index] = selectedImage;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: theme.primaryColor,
                    ),
                    6.w.horizontalSpace,
                    Text(
                      userSelectedImages[index] != null ? 'update' : 'add',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 14.spMin,
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }

  @override
  bool validate() {
    bool isNotValid = userSelectedImages.any((element) => element == null);
    return !isNotValid;
  }

  @override
  List<File> getApiData() {
    return userSelectedImages
        .map(
          (e) => File(e!),
        )
        .toList();
  }

  @override
  String? getError() {
    return userSelectedImages.any(
      (element) => element == null,
    )
        ? "please select workspace photos"
        : null;
  }
}
