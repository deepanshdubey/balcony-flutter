import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';

import 'tenant_application_controller.dart';

class TenantApplicationForm extends StatelessWidget {
  final TenantApplicationController controller;
  final PropertyData? propertyData;
  final Tenants? tenant;
  final bool isUpdate;

  const TenantApplicationForm({
    super.key,
    required this.controller,
    this.propertyData,
    this.tenant,
    this.isUpdate = false,
  });

  @override
  Widget build(BuildContext context) {
    List<UnitList>? units = isUpdate
        ? tenant?.selectedUnit?.property?.unitList
        : propertyData?.unitList;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Text(
            "info*",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 28.spMin,
                  fontWeight: FontWeight.w600,
                  color: appColor.primaryColor,
                ),
          ),
          16.verticalSpace,
          AppTextField(
            controller: controller.firstNameController,
            focusNode: controller.firstNameNode,
            label: 'first name',
            hintText: "enter your first name",
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,
          AppTextField(
            controller: controller.lastNameController,
            focusNode: controller.lastNameNode,
            label: 'last name*',
            hintText: "enter your last name",
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,
          AppTextField(
            controller: controller.phoneNumberController,
            focusNode: controller.phoneNumberNode,
            label: 'phone number',
            hintText: "enter your phone number",
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          16.verticalSpace,
          AppTextField(
            controller: controller.emailController,
            focusNode: controller.emailNode,
            label: 'email',
            hintText: "enter your email",
            keyboardType: TextInputType.emailAddress,
          ),
          16.verticalSpace,
          AppTextField(
            controller:controller.buildingController,
            label: 'building',
            readOnly: true,

          ),
          16.verticalSpace,
          AppDropdownField<UnitList?>(
            controller: controller.selectedUnitController,
            label: "apt. of interest",
            items: units ?? [],
            itemLabel: (p0) => p0?.unit?.toString().toLowerCase() ?? "-",
            onItemSelected: (p0) {
              controller.selectedUnit = p0?.unit?.toString();
            },
          ),
          16.verticalSpace,
          AppTextField(
            controller: controller.anticipateController,
            label: 'anticipated move-in request',
            hintText: "01/02/2025",
            keyboardType: TextInputType.none,
            readOnly: true,
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (selectedDate != null) {
                controller.anticipateController.text =
                    "${selectedDate.month.toString().padLeft(2, '0')}/"
                    "${selectedDate.day.toString().padLeft(2, '0')}/"
                    "${selectedDate.year}";
                controller.selectedMoveInDate = selectedDate.toIso8601String();
              }
            },
          ),
          16.verticalSpace,
        ],
      ),
    );
  }
}
