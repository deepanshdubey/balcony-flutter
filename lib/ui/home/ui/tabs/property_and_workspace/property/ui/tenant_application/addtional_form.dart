import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/widget/app_text_field.dart';

class AdditionalForm extends StatefulWidget {
  const AdditionalForm({super.key});

  @override
  State<AdditionalForm> createState() => _AdditionalFormState();
}

class _AdditionalFormState extends BaseState<AdditionalForm> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Map<String, dynamic> getApiData() {
    return {
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
    };
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: firstNameController,
            label: 'first name',
            hintText: '..',
          ),
          12.h.verticalSpace,
          AppTextField(
            controller: lastNameController,
            label: 'last name',
            hintText: '..',
          ),
          12.h.verticalSpace,
          AppTextField(
            controller: emailController,
            label: 'email',
            hintText: '..',
          ),
          12.h.verticalSpace,
          Divider(
            color: appColor.primaryColor,
            thickness: 1.h,
          ),
          12.h.verticalSpace,
        ],
      ),
    );
  }

  @override
  String? getError() {
    return null;
  }
}
