import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchPropertiesWidget extends StatefulWidget {
  const SearchPropertiesWidget({super.key});

  @override
  State<SearchPropertiesWidget> createState() => _SearchPropertiesWidgetState();
}

class _SearchPropertiesWidgetState extends State<SearchPropertiesWidget> {
  late final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController placeController;
  late TextEditingController bedsController;
  late TextEditingController bathsController;
  late TextEditingController minRangeController;
  late TextEditingController maxRangeController;
  late FocusNode placeNode;
  late FocusNode bedsNode;
  late FocusNode bathsNode;
  late FocusNode minRangeNode;
  late FocusNode maxRangeNode;

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController();
    bedsController = TextEditingController();
    bathsController = TextEditingController();
    minRangeController = TextEditingController();
    maxRangeController = TextEditingController();
    placeNode = FocusNode();
    bedsNode = FocusNode();
    bathsNode = FocusNode();
    minRangeNode = FocusNode();
    maxRangeNode = FocusNode();
  }

  @override
  void dispose() {
    placeController.dispose();
    bedsController.dispose();
    bathsController.dispose();
    minRangeController.dispose();
    maxRangeController.dispose();
    placeNode.dispose();
    bedsNode.dispose();
    bathsNode.dispose();
    minRangeNode.dispose();
    maxRangeNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(color: Colors.black.withOpacity(.25))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            AppTextField(
              controller: placeController,
              focusNode: placeNode,
              validator: (place) {
                if (place?.isNotEmpty == true) {
                  return null;
                } else {
                  return 'please enter city';
                }
              },
              label: 'place*',
              hintText: "city",
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            SizedBox(
              width: context.width / 2,
              child: AppTextField(
                controller: bedsController,
                focusNode: bedsNode,
                keyboardType: TextInputType.number,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: AppImage(
                    height: 16.r,
                    width: 16.r,
                    assetPath: theme.assets.beds,
                  ),
                ),
                label: 'beds',
                hintText: '2..',
              ),
            ),
            16.h.verticalSpace,
            SizedBox(
              width: context.width / 2,
              child: AppTextField(
                controller: bathsController,
                focusNode: bathsNode,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.r),
                  child: AppImage(
                    height: 16.r,
                    width: 16.r,
                    assetPath: theme.assets.baths,
                  ),
                ),
                keyboardType: TextInputType.number,
                label: 'baths',
                hintText: '2..',
              ),
            ),
            16.h.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: minRangeController,
                    focusNode: minRangeNode,
                    label: 'min range',
                    hintText: '##',
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                  width: 10.w,
                  height: 1.h,
                  color: theme.colors.dividerColor,
                ),
                Expanded(
                  child: AppTextField(
                    controller: maxRangeController,
                    focusNode: maxRangeNode,
                    label: 'max range',
                    hintText: '##',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            10.h.verticalSpace,
            PrimaryButton(
              text: "search",
              onPressed: () {
                if (_formKey.currentState!.validate() == true) {
                  logger.w("message");
                }
              },
            ),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget socialButton(ThemeData theme,
      {required String image,
      required String text,
      required VoidCallback onPressed}) {
    return Expanded(
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            backgroundColor: Colors.transparent,
            side: BorderSide(color: Theme.of(context).colors.strokeColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            )),
        icon: AppImage(
          assetPath: image,
          height: 16.r,
          width: 16.r,
        ),
        onPressed: onPressed,
        label: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.spMin,
          ),
        ),
      ),
    );
  }
}
