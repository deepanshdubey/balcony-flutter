import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/ui/auth/store/auth_store.dart';
import 'package:homework/ui/auth/ui/bottomsheet/alert/verification_alert.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/password_field.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback onSuccess;
  const SignUpPage({super.key, required this.onSuccess});

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
  List<ReactionDisposer>? disposers;
  late Map<String, dynamic> apiRequest;
  final authStore = AuthStore();

  @override
  void initState() {
    super.initState();
    addDisposer();
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
    removeDisposer();
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

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.registerResponse, (response) {
        if (response != null) {
          alertManager.showAlert(
              context,
              VerificationAlert(
                type: VerificationAlertType.register,
                apiRequest: apiRequest,
                onSuccess: () {
                  widget.onSuccess();
                },
              ));
        }
      }),
      reaction((_) => authStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
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
    final theme = Theme.of(context);
    return Observer(builder: (context) {
      var isLoading = authStore.isLoading;
      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
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
                        keyboardType: TextInputType.emailAddress,
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
                      AppTextField(
                        controller: emailController,
                        focusNode: emailNode,
                        validator: emailValidator.call,
                        label: 'email',
                        hintText: 'name@email.com',
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
                        isLoading: isLoading,
                        text: "register",
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            apiRequest = {
                              "firstName": firstNameController.text.trim(),
                              "lastName": lastNameController.text.trim(),
                              "email": emailController.text.trim(),
                              "phone": phoneController.text.trim(),
                              "password": passwordController.text.trim(),
                            };
                            authStore.register(apiRequest);
                          }
                        },
                      ),
                      16.h.verticalSpace,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
