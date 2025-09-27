import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_text_field.dart';

class EmploymentDetailsWidget extends StatefulWidget {
  const EmploymentDetailsWidget({super.key});

  @override
  State<EmploymentDetailsWidget> createState() =>
      _EmploymentDetailsWidgetState();
}

class _EmploymentDetailsWidgetState extends BaseState<EmploymentDetailsWidget> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController employerNameController;
  late TextEditingController companyAddressController;
  late TextEditingController companyPhoneController;
  late TextEditingController jobTitleController;

  @override
  void initState() {
    super.initState();
    employerNameController = TextEditingController();
    companyAddressController = TextEditingController();
    companyPhoneController = TextEditingController();
    jobTitleController = TextEditingController();
  }

  @override
  void dispose() {
    employerNameController.dispose();
    companyAddressController.dispose();
    companyPhoneController.dispose();
    jobTitleController.dispose();
    super.dispose();
  }

  @override
  Map<String, dynamic> getApiData() {
    return {
      "employment": {
        "company": employerNameController.text,
        "address": companyAddressController.text,
        "phone": companyPhoneController.text,
        "job": jobTitleController.text
      },
    };
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border:
              Border.all(color: Theme.of(context).primaryColor.withAlpha(60))),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            Text(
              "employment details",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            Text(
              "(most recent or current employer)",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: employerNameController,
              label: 'employer name (company name)',
              hintText: '..',
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: companyAddressController,
              label: 'company address',
              hintText: '..',
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: companyPhoneController,
              label: 'company phone #',
              hintText: '+1',
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: jobTitleController,
              label: 'your job title',
              hintText: '..',
            ),
            12.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  String? getError() {
    return null;
  }
}
