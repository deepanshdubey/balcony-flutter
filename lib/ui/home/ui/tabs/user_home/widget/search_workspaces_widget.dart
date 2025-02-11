import 'package:auto_route/auto_route.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

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
  String checkInDate = " ";
  String checkOutDate = " ";

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
                if (place == null || place.trim().isEmpty) {
                  return 'Please enter a city';
                }
                return null;
              },
              label: 'Place*',
              hintText: "City",
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: checkInController,
              focusNode: checkInNode,
              readOnly: true,
              validator: (date) {
                if (date == null || date.trim().isEmpty) {
                  return 'Please select a check-in date';
                }
                return null;
              },
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  String formattedDate = DateFormat('MM/dd').format(selectedDate);
                  checkInController.text = formattedDate;
                  checkInDate = selectedDate.toIso8601String();
                }
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.r),
                child: AppImage(
                  height: 16.r,
                  width: 16.r,
                  assetPath: theme.assets.calender,
                ),
              ),
              label: 'Check In',
              hintText: 'MM/DD',
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: checkOutController,
              focusNode: checkOutNode,
              readOnly: true,
                validator: (date) {
                  if (checkInDate.trim().isEmpty || checkInDate == " ") {
                    return 'Please select a check-in date first';
                  }
                  if (date == null || date.trim().isEmpty) {
                    return 'Please select a check-out date';
                  }
                  try {
                    final checkIn = DateTime.parse(checkInDate);
                    final checkOut = DateTime.parse(checkOutDate);

                    if (checkOut.isBefore(checkIn)) {
                      return 'Check-out date cannot be before check-in date';
                    }
                  } catch (e) {
                    return 'Invalid date format';
                  }
                  return null;
                },

                onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (selectedDate != null) {
                  String formattedDate = DateFormat('MM/dd').format(selectedDate);
                  checkOutController.text = formattedDate;
                  checkOutDate = selectedDate.toIso8601String();
                }
              },
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.r),
                child: AppImage(
                  height: 16.r,
                  width: 16.r,
                  assetPath: theme.assets.calender,
                ),
              ),
              label: 'Check Out',
              hintText: 'MM/DD',
            ),
            16.h.verticalSpace,
            SizedBox(
              width: context.width / 2,
              child: AppTextField(
                controller: peopleController,
                focusNode: peopleNode,
                validator: (people) {
                  if (people == null || people.trim().isEmpty) {
                    return 'Please enter the number of people';
                  }
                  if (int.tryParse(people) == null || int.parse(people) <= 0) {
                    return 'Please enter a valid number of people';
                  }
                  return null;
                },
                label: 'People',
                hintText: '##',
                keyboardType: TextInputType.number,
              ),
            ),
            10.h.verticalSpace,
            PrimaryButton(
              text: "Search",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.router.push(SearchWorkspaceRoute(
                    place: placeController.text,
                    checkIn: checkInDate,
                    checkOut: checkOutDate,
                    people: int.parse(peopleController.text),
                  ));
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
