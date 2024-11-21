import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchWorkspacesWidget extends StatefulWidget {
  const SearchWorkspacesWidget({super.key});

  @override
  State<SearchWorkspacesWidget> createState() => _SearchWorkspacesWidgetState();
}

class _SearchWorkspacesWidgetState extends State<SearchWorkspacesWidget> {
  late final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController placeController;
  late TextEditingController checkInController;
  late TextEditingController checkOutController;
  late TextEditingController peopleController;
  late FocusNode placeNode;
  late FocusNode checkInNode;
  late FocusNode checkOutNode;
  late FocusNode peopleNode;

  @override
  void initState() {
    super.initState();
    placeController = TextEditingController();
    checkInController = TextEditingController();
    checkOutController = TextEditingController();
    peopleController = TextEditingController();
    placeNode = FocusNode();
    checkInNode = FocusNode();
    checkOutNode = FocusNode();
    peopleNode = FocusNode();
  }

  @override
  void dispose() {
    placeController.dispose();
    checkInController.dispose();
    checkOutController.dispose();
    peopleController.dispose();
    placeNode.dispose();
    checkInNode.dispose();
    checkOutNode.dispose();
    peopleNode.dispose();
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
            AppTextField(
              controller: checkInController,
              focusNode: checkInNode,
              readOnly: true,
              onTap: () {},
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.r),
                child: AppImage(
                  height: 16.r,
                  width: 16.r,
                  assetPath: theme.assets.calender,
                ),
              ),
              label: 'check in',
              hintText: 'MM/DD',
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: checkOutController,
              focusNode: checkOutNode,
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.r),
                child: AppImage(
                  height: 16.r,
                  width: 16.r,
                  assetPath: theme.assets.calender,
                ),
              ),
              readOnly: true,
              onTap: () {},
              label: 'check out',
              hintText: 'MM/DD',
            ),
            16.h.verticalSpace,
            SizedBox(
              width: context.width / 2,
              child: AppTextField(
                controller: peopleController,
                focusNode: peopleNode,
                label: 'people',
                hintText: '##',
                keyboardType: TextInputType.number,
              ),
            ),
            10.h.verticalSpace,
            PrimaryButton(
              text: "search",
              onPressed: () {
                if (_formKey.currentState!.validate() == true) {
                 context.router.push(WorkspaceRoute());
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
