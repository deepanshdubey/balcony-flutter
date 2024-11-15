import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceInfoWidget extends StatelessWidget {
  const WorkspaceInfoWidget({
    super.key,
    required this.formKey,
    required this.workspaceNameController,
    required this.floorController,
    required this.addressController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController workspaceNameController;
  final TextEditingController floorController;

  final TextEditingController addressController;

  final TextEditingController cityController;

  final TextEditingController stateController;

  final TextEditingController countryController;

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
              "workspace amenities*",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: workspaceNameController,
              label: 'name of workspace',
              hintText: 'the square',
              validator: workspaceNameValidator.call,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: addressController,
              validator: addressValidator.call,
              label: 'address',
              hintText: '123 address..',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: floorController,
              validator: addressValidator.call,
              label: 'floor, apt., etc.',
              hintText: 'floor 2',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: cityController,
              validator: cityValidator.call,
              label: 'city',
              hintText: 'new york city',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: stateController,
              keyboardType: TextInputType.text,
              validator: stateValidator.call,
              label: 'state',
              hintText: 'new york',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: countryController,
              validator: countryValidator.call,
              label: 'country',
              hintText: 'united states',
            ),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
