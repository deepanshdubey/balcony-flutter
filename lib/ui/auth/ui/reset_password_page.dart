import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                25.h.verticalSpace,
                AppTextField(
                  controller: emailController,
                  focusNode: emailNode,
                  validator: emailOrPhoneValidator.call,
                  label: 'email or phone number',
                  hintText: "email or phone number",
                  textInputAction: TextInputAction.next,
                ),
                16.h.verticalSpace,
                PrimaryButton(
                  text: "reset password",
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
