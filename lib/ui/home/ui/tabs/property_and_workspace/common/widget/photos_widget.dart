import 'dart:io';

import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhotosWidget extends StatefulWidget {
  final bool isWorkspace;
  final List<String>? existingImages;

  const PhotosWidget({super.key, this.isWorkspace = true, this.existingImages});

  @override
  State<PhotosWidget> createState() => PhotosWidgetState();
}

class PhotosWidgetState extends BaseState<PhotosWidget> {
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
            widget.isWorkspace ? "workspace photos* " : "property photos*",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
          ),
          16.h.verticalSpace,
          photoPicker(0),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: photoPicker(1),
              ),
              6.w.horizontalSpace,
              Expanded(
                child: photoPicker(2),
              ),
            ],
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  Widget photoPicker(int index) {
    return Stack(
      children: [
        Container(
          height: 160.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
          ),
          child: userSelectedImages[index] != null ||
                  widget.existingImages?[index] != null
              ? AppImage(
                  height: double.infinity,
                  width: double.infinity,
                  radius: 12.r,
                  boxFit: BoxFit.cover,
                  url: (userSelectedImages[index] == null)
                      ? (widget.existingImages?[index])
                      : null,
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
                      (userSelectedImages[index] != null ||
                              widget.existingImages?[index] != null)
                          ? 'update'
                          : 'add',
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
    return widget.existingImages != null ? true : !isNotValid;
  }

  @override
  List<dynamic> getApiData() {
    return widget.existingImages != null || !widget.isWorkspace
        ? userSelectedImages.asMap().entries.map((entry) {
            final index = entry.key;
            final selectedImage = entry.value;

            // Check if the selected image is null
            if (selectedImage == null) {
              // Return the URL from the existing URLs list
              return widget.existingImages?[index] as String; // existingUrls should be defined elsewhere
            }

            // Otherwise, create a File from the selected image
            return selectedImage;
          }).toList() // this should be list of String not String?
        : userSelectedImages
            .map(
              (e) => File(e ?? ""),
            )
            .toList();
  }

  @override
  String? getError() {
    return userSelectedImages.any(
      (element) => element == null,
    )
        ? "please select ${widget.isWorkspace ? 'workspace' : 'property'} photos"
        : null;
  }
}
