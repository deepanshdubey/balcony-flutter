import 'package:auto_route/auto_route.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/router/app_router.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/stay/rant_payment_details_page.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../../../widget/app_outlined_button.dart';

class ReviewTenantApplication extends StatefulWidget {
  final PropertyData? propertyData;
  final Tenants? tenant;
  final bool? isUpdate;
  final bool? onlyShowData;

  const ReviewTenantApplication(
      {super.key, this.propertyData, this.tenant, this.isUpdate, this.onlyShowData});

  @override
  State<ReviewTenantApplication> createState() =>
      _ReviewTenantApplicationState();
}

class _ReviewTenantApplicationState extends State<ReviewTenantApplication> {
  List<ReactionDisposer>? disposers;
  late final GlobalKey<FormState> _formKey = GlobalKey();
  final ValueNotifier<bool> isAgreedNotifier = ValueNotifier(true);
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
  String? leaseStartDate;
  String? leaseEndDate;
  String? selectedUnit;
  String? selectedMoveInDate;
  bool isSecurityDepositChecked = false;
  bool isSameAsRent = false;
  int depositFeeAmount = 0;

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
    firstNameController.text = widget.tenant?.info?.firstName ?? "";
    lastNameController.text = widget.tenant?.info?.lastName ?? "";
    phoneNumberController.text = widget.tenant?.info?.phone ?? "";
    emailController.text = widget.tenant?.info?.email ?? "";
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

  void approveTenant() {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }
    var request = {
    if(!isSameAsRent)  "securityDepositFee": depositFeeAmount,
      "isSameAsRent": isSameAsRent,
      "leaseStartDate": leaseStartDate,
      "leaseEndDate": leaseEndDate
    };
    propertyStore.approveTenant(widget.tenant?.Id ?? "", request);
  }

  void rejectTenant() {
    if (!isAgreedNotifier.value) {
      alertManager.showError(
          context, "Please agree to all terms and conditions");
      return;
    }

    propertyStore.rejectTenant(widget.tenant?.Id ?? "");
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => propertyStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
      reaction((_) => propertyStore.approveTenantResponse,
          (CommonData? response) {
        if (response?.success ?? false) {
          context.router.maybePop();
        }
      }),
      reaction((_) => propertyStore.rejectTenantResponse,
          (CommonData? response) {
        if (response?.success ?? false) {
     context.router.maybePop();
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
                "Info*",
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
                  AppTextField(
                    readOnly: true,
                    controller: firstNameController,
                    focusNode: firstNameNode,
                    label: 'First Name*',
                    hintText: "Enter your first name",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: lastNameController,
                    focusNode: lastNameNode,
                    label: 'Last Name*',
                    hintText: "Enter your last name",
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
                    controller: phoneNumberController,
                    focusNode: phoneNumberNode,
                    label: 'Phone Number*',
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                  ),
                  16.h.verticalSpace,
                  AppTextField(
                    readOnly: true,
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
                    widget.tenant?.selectedUnit?.property?.info?.city ?? "",
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
                  10.h.verticalSpace,
                  Text(
                    widget.tenant?.selectedUnit?.unit.toString() ?? "",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w400,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  AppTextField(
                    controller: anticipateController,
                    focusNode: emailNode,
                    label: 'Anticipated Move-in Request',
                    hintText: formatDate(widget.tenant?.info?.moveInRequest),
                    keyboardType: TextInputType.none,
                    readOnly: true,
                  ),
                  16.verticalSpace
                ],
              ),
            ),
            24.verticalSpace,
            if(widget.onlyShowData ??true)   Container(
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
                    "prospect tenant agreed to the following:",
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
            if(widget.onlyShowData ??true)     24.verticalSpace,
            if(widget.onlyShowData ??true)      Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
                border: Border.all(color: Colors.black.withOpacity(.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Do you charge security deposit?*",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 24.spMin,
                          fontWeight: FontWeight.w800,
                          color: appColor.primaryColor,
                        ),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: isSecurityDepositChecked,
                            onChanged: (value) {
                              setState(() {
                                isSecurityDepositChecked = value ?? false;
                                isSameAsRent = false;
                              });
                            },
                          ),
                          Text(
                            "yes",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14.spMin,
                                ),
                          ),
                        ],
                      ),
                      20.horizontalSpace,
                      Row(
                        children: [
                          Checkbox(
                            value: !isSecurityDepositChecked,
                            onChanged: (value) {
                              setState(() {
                                isSecurityDepositChecked = !(value ?? false);
                                isSameAsRent = false;
                              });
                            },
                          ),
                          Text(
                            "no",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontSize: 14.spMin,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  if (isSecurityDepositChecked) ...[
                    16.verticalSpace,
                    Text(
                      "deposit fee amount",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.spMin,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    8.verticalSpace,
                    TextField(
                      decoration: InputDecoration(
                        hintText: "1000",
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          depositFeeAmount = int.parse(value);
                        });
                      },
                    ),
                  ],
                  16.verticalSpace,
                  Row(
                    children: [
                      Checkbox(
                        value: isSameAsRent,
                        onChanged: (value) {
                          setState(() {
                            isSameAsRent = value ?? false;
                            if (isSameAsRent) {
                              isSecurityDepositChecked = true;
                              depositFeeAmount = 0; // Example value
                            }
                          });
                        },
                      ),
                      Text(
                        "same amount as rent",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 14.spMin,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if(widget.onlyShowData ??true)      25.verticalSpace,
       if(widget.onlyShowData ??true)    LeaseDurationWidget(onDateChanged: (DateTime? startDate, DateTime? endDate) {
              leaseStartDate = startDate?.toIso8601String() ;
              leaseEndDate = endDate?.toIso8601String() ;
            },),
            if(widget.onlyShowData ??true)   25.verticalSpace,
            if(widget.onlyShowData ??true)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: PrimaryButton(
                text: "proceed to next phase",
                onPressed: approveTenant,
              ),
            ),
            if(widget.onlyShowData ??true)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text(
                "**Note: If application is approved by you, then the tenant would see an approved for signing lease user interface where they can now make the deposit.ß",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 11.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            if(widget.onlyShowData ??true)  16.verticalSpace,
            if(widget.onlyShowData ??true)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: AppOutlinedButton(
                  text: "disapprove application", onPressed: () {
                    propertyStore.rejectTenant(widget.tenant?.Id ?? "");
                context.router.maybePop();
              }),
            ),
            if(widget.onlyShowData ??false)   Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text(
                "**Note: Disapproving an application would disqualify this applicant from renting this unit. The prospect would have to reapply if they are ever interested in inquiring about the unit.",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 11.spMin,
                      fontWeight: FontWeight.w800,
                      color: appColor.primaryColor,
                    ),
              ),
            ),
            if(widget.onlyShowData ??false)   30.verticalSpace
          ],
        ),
      ),
    );
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      return DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
    } catch (e) {
      print("Error parsing date: $e");
      return "";
    }
  }
}

class LeaseDurationWidget extends StatefulWidget {
  final Function(DateTime? startDate, DateTime? endDate) onDateChanged;

  const LeaseDurationWidget({Key? key, required this.onDateChanged}) : super(key: key);

  @override
  _LeaseDurationWidgetState createState() => _LeaseDurationWidgetState();
}

class _LeaseDurationWidgetState extends State<LeaseDurationWidget> {
  DateTime? leaseStartDate;
  DateTime? leaseEndDate;

  String formatDate(DateTime? date) {
    return date != null ? "${date.month}/${date.day}" : "";
  }

  Future<void> pickDate(BuildContext context, bool isStartDate) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(2000);
    DateTime lastDate = DateTime(2100);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? leaseStartDate ?? initialDate
          : leaseEndDate ?? initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          leaseStartDate = pickedDate;
        } else {
          leaseEndDate = pickedDate;
        }
      });

      // Call the callback to notify the parent widget
      widget.onDateChanged(leaseStartDate, leaseEndDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "What’s the lease duration?*",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 24.spMin,
              fontWeight: FontWeight.w800,
              color: appColor.primaryColor,
            ),
          ),
          16.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lease start date",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.verticalSpace,
                  GestureDetector(
                    onTap: () => pickDate(context, true),
                    child: Container(
                      width: 120.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16.spMin, color: Colors.grey),
                          Text(
                            formatDate(leaseStartDate),
                            style: TextStyle(fontSize: 14.spMin),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "lease end date",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  8.verticalSpace,
                  GestureDetector(
                    onTap: () => pickDate(context, false),
                    child: Container(
                      width: 120.w,
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black.withOpacity(0.3)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.calendar_today,
                              size: 16.spMin, color: Colors.grey),
                          Text(
                            formatDate(leaseEndDate),
                            style: TextStyle(fontSize: 14.spMin),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

