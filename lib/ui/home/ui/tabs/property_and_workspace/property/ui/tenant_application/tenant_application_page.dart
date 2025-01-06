import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/stay/rant_payment_details_page.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class TenantApplicationPage extends StatefulWidget {
  final PropertyData? propertyData;
  final Tenants? tenant;
  final bool? isUpdate;

  const TenantApplicationPage(
      {super.key, this.propertyData, this.tenant, this.isUpdate});

  @override
  State<TenantApplicationPage> createState() => _TenantApplicationPageState();
}

class _TenantApplicationPageState extends State<TenantApplicationPage> {
  List<ReactionDisposer>? disposers;
  late final GlobalKey<FormState> _formKey = GlobalKey();
  final ValueNotifier<bool> isAgreedNotifier = ValueNotifier(false);
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController anticipateController;
  late TextEditingController socialSecurityController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode phoneNumberNode;
  late FocusNode emailNode;
  late FocusNode socialSecurityNode;
  String? selectedTitle;
  String? selectedUnit;
  String? selectedMoveInDate;

  var propertyStore = PropertyStore();

  @override
  void initState() {
    addDisposer();
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    anticipateController = TextEditingController();
    socialSecurityController = TextEditingController();
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    phoneNumberNode = FocusNode();
    emailNode = FocusNode();
    socialSecurityNode = FocusNode();
    firstNameController.text = session.user.firstName ?? "";
    lastNameController.text = session.user.lastName ?? "";
    phoneNumberController.text = session.user.phone ?? "";
    emailController.text = session.user.email ?? "";
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    phoneNumberNode.dispose();
    emailNode.dispose();
    removeDisposer();
    super.dispose();
  }

  void submitApplication() {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }

    var request = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "selectedUnitId": selectedUnit,
      "moveInRequest": selectedMoveInDate,
      "currency":"USD"
    };

    propertyStore.applyTenant(request);
  }

  void updateApplication() {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }

    var request = {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "selectedUnitId": selectedUnit,
      "moveInRequest": selectedMoveInDate,
    };

    propertyStore.updateTenant(widget.tenant?.Id ?? "", request);
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => propertyStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => propertyStore.applyTenantResponse,
          (CommonData? response) {
        if (response?.success ?? false) {
          alertManager.showSuccess(context, response?.message ?? "");
        }
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              child: Text(
                "hello ${session.user.firstName} we need a few information about you.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 28.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            24.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    "info*",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 28.spMin,
                          fontWeight: FontWeight.w800,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    controller: firstNameController,
                    focusNode: firstNameNode,
                    label: 'First Name*',
                    hintText: "Enter your first name",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    controller: lastNameController,
                    focusNode: lastNameNode,
                    label: 'Last Name*',
                    hintText: "Enter your last name",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    controller: phoneNumberController,
                    focusNode: phoneNumberNode,
                    label: 'Phone Number*',
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    controller: emailController,
                    focusNode: emailNode,
                    label: 'Email*',
                    hintText: "Enter your email address",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  16.verticalSpace,
                  Text(
                    "Building",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  Text(
                    "124 Jacob Street",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                  Text(
                    "apt. of interest",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                          color: appColor.primaryColor,
                        ),
                  ),
                  6.h.verticalSpace,
                  DropdownButtonFormField<String>(
                    padding: EdgeInsets.zero,
                    icon: 0.verticalSpace,
                    value: selectedTitle,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20).r,
                      labelText: "Title*",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    items: (widget.isUpdate??false
                        ? widget.tenant?.selectedUnit?.property?.unitList
                        : widget.propertyData?.unitList)
                        ?.map((title) => DropdownMenuItem<String>(
                      value: title.unit.toString(),
                      child: Text(title.unit.toString()),
                    ))
                        .toList(),
                    onChanged: (value) {
                      selectedUnit = (widget.isUpdate??false
                          ? widget.tenant?.selectedUnit?.property?.unitList
                          : widget.propertyData?.unitList)
                          ?.firstWhere((unit) => unit.unit.toString() == value)
                          .Id;
                    },
                  ),

                  16.verticalSpace,
                  AppTextField(
                    controller: anticipateController,
                    focusNode: emailNode,
                    label: 'Anticipated Move-in Request',
                    hintText: "01/02/2025",
                    keyboardType: TextInputType.none,
                    // Disable keyboard input
                    readOnly: true,
                    // Make the field read-only to show picker only
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
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
                  16.verticalSpace
                ],
              ),
            ),
            24.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    "credit check",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 28.spMin,
                          fontWeight: FontWeight.w800,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    controller: socialSecurityController,
                    focusNode: firstNameNode,
                    label: 'social security number',
                    hintText: "***-******",
                    textInputAction: TextInputAction.next,
                  ),
                  16.verticalSpace
                ],
              ),
            ),
            24.verticalSpace,
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Text(
                    "terms of service*",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 28.spMin,
                          fontWeight: FontWeight.w800,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  ValueListenableBuilder<bool>(
                    valueListenable: isAgreedNotifier,
                    builder: (context, isAgreed, _) {
                      return AgreementCheckboxes(
                        onAllChecked: () {
                          isAgreedNotifier.value = true;
                        },
                      );
                    },
                  ),
                  16.h.verticalSpace,
                ],
              ),
            ),
            25.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: PrimaryButton(
                text: widget.isUpdate ?? false
                    ? "update Application"
                    : "submit application",
                onPressed: widget.isUpdate ?? false
                    ? updateApplication
                    : submitApplication,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text(
                "**Note: If application is approved by property manager, then you will be prompted to next step(s) which is usually leasing agreement & first month rent & security.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 11.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            30.verticalSpace
          ],
        ),
      ),
    );
  }
}
