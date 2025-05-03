import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/widget/app_text_field.dart';

class EmergencyForm extends StatefulWidget {
  const EmergencyForm({super.key});

  @override
  State<EmergencyForm> createState() => _EmergencyFormState();
}

class _EmergencyFormState extends State<EmergencyForm> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Info getApiData() {
    return Info(
      address: nameController.text.trim(),
      country: phoneController.text.trim(),
      summary: 'a',
    );
  }

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
            controller: nameController,
            label: 'name',
            hintText: 'name goes here',
          ),
          12.h.verticalSpace,
          AppTextField(
            controller: phoneController,
            label: 'phone',
            hintText: '+1',
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
}
