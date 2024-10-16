import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/password_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode phoneNode;
  late FocusNode passwordNode;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Container(
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
                  controller: firstNameController,
                  focusNode: firstNameNode,
                  validator: firstNameValidator.call,
                  label: 'first name',
                  hintText: 'first name',
                  textInputAction: TextInputAction.next,
                ),
                16.h.verticalSpace,
                AppTextField(
                  controller: lastNameController,
                  focusNode: lastNameNode,
                  validator: lastNameValidator.call,
                  label: 'last name',
                  hintText: 'last name',
                  textInputAction: TextInputAction.next,
                ),
                16.h.verticalSpace,
                PasswordField(
                  controller: passwordController,
                  focusNode: passwordNode,
                  validator: passwordValidator.call,
                  label: 'password',
                  hintText: 'password',
                ),
                16.h.verticalSpace,
                AppTextField(
                  controller: phoneController,
                  focusNode: phoneNode,
                  keyboardType: TextInputType.number,
                  validator: phoneValidator.call,
                  label: 'phone',
                  hintText: '###-###-####',
                  textInputAction: TextInputAction.next,
                ),
                10.h.verticalSpace,
                PrimaryButton(
                  text: "register",
                  onPressed: () {
                    if (_formKey.currentState?.validate() == true) {}
                  },
                ),
                16.h.verticalSpace,
              ],
            ),
          ),

        ],
      ),
    );
  }
}
