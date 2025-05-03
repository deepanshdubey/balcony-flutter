import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';

class TenantApplicationForm extends StatefulWidget {
  final PropertyData? propertyData;
  final Tenants? tenant;
  final bool isUpdate;

  const TenantApplicationForm({
    super.key,
    this.propertyData,
    this.tenant,
    this.isUpdate = false,
  });

  @override
  State<TenantApplicationForm> createState() => _TenantApplicationFormState();
}

class _TenantApplicationFormState extends BaseState<TenantApplicationForm> {
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController selectedUnitController;
  late TextEditingController anticipateController;
  late TextEditingController buildingController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode phoneNumberNode;
  late FocusNode emailNode;
  late FocusNode selectedUnitNode;
  String? selectedUnit;
  String? selectedMoveInDate;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    anticipateController = TextEditingController();
    selectedUnitController = TextEditingController();
    buildingController = TextEditingController();

    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    phoneNumberNode = FocusNode();
    emailNode = FocusNode();
    selectedUnitNode = FocusNode();

    firstNameController.text = session.user.firstName ?? "";
    lastNameController.text = session.user.lastName ?? "";
    phoneNumberController.text = session.user.phone ?? "";
    emailController.text = session.user.email ?? "";
    selectedUnitController.text = selectedUnit ?? "";
    buildingController.text = widget.propertyData?.info?.name ?? "Unknown";
  }

  @override
  Widget build(BuildContext context) {
    List<UnitList>? units = widget.isUpdate
        ? widget.tenant?.selectedUnit?.property?.unitList
        : widget.propertyData?.unitList;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Form(
        key: formKey,
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
              controller: firstNameController,
              focusNode: firstNameNode,
              label: 'first name',
              hintText: "enter your first name",
              validator: requiredValidator.call,
              textInputAction: TextInputAction.next,
            ),
            16.verticalSpace,
            AppTextField(
              controller: lastNameController,
              focusNode: lastNameNode,
              label: 'last name*',
              hintText: "enter your last name",
              validator: requiredValidator.call,
              textInputAction: TextInputAction.next,
            ),
            16.verticalSpace,
            AppTextField(
              controller: phoneNumberController,
              focusNode: phoneNumberNode,
              label: 'phone number',
              hintText: "enter your phone number",
              keyboardType: TextInputType.phone,
              validator: requiredValidator.call,
              textInputAction: TextInputAction.next,
            ),
            16.verticalSpace,
            AppTextField(
              controller: emailController,
              focusNode: emailNode,
              label: 'email',
              hintText: "enter your email",
              validator: requiredValidator.call,
              keyboardType: TextInputType.emailAddress,
            ),
            16.verticalSpace,
            AppTextField(
              controller: buildingController,
              label: 'building',
              readOnly: true,
            ),
            16.verticalSpace,
            AppDropdownField<UnitList?>(
              controller: selectedUnitController,
              label: "apt. of interest",
              items: units ?? [],
              itemLabel: (p0) => p0?.unit?.toString().toLowerCase() ?? "-",
              validator: requiredValidator.call,
              onItemSelected: (p0) {
                selectedUnit = p0?.unit?.toString();
              },
            ),
            16.verticalSpace,
            AppTextField(
              controller: anticipateController,
              label: 'anticipated move-in request',
              hintText: "01/02/2025",
              keyboardType: TextInputType.none,
              validator: requiredValidator.call,
              readOnly: true,
              onTap: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (selectedDate != null) {
                  anticipateController.text =
                      "${selectedDate.month.toString().padLeft(2, '0')}/"
                      "${selectedDate.day.toString().padLeft(2, '0')}/"
                      "${selectedDate.year}";
                  selectedMoveInDate = selectedDate.toIso8601String();
                }
              },
            ),
            16.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  Map<String, dynamic> getApiData() {
    return {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "moveInRequest": selectedMoveInDate,
      "selectedUnitId": selectedUnit,
    };
  }

  @override
  String? getError() {
    return null;
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() == true;
  }
}
