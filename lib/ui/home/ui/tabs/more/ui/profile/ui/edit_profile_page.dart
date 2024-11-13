import 'dart:io';

import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/core/session/app_session.dart';
import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/auth/store/auth_store.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/image_picker_widget.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  bool firstName = true, lastName = true, email = true, phone = true;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode emailNode;
  late FocusNode phoneNode;
  List<ReactionDisposer>? disposers;
  final authStore = AuthStore();
  String? imagePath;

  @override
  void initState() {
    var user = session.user;
    logger.i(user.toJson());
    _formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController(text: user.firstName ?? "");
    lastNameController = TextEditingController(text: user.lastName ?? "");
    emailController = TextEditingController(text: user.email ?? "");
    phoneController = TextEditingController(text: user.phone ?? "");
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    emailNode = FocusNode();
    phoneNode = FocusNode();
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => authStore.updateProfileResponse, (response) {
        if (response != null) {
          alertManager.showSuccess(context, "profile updated successfully");
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
    return Scaffold(
      body: Column(
        children: [
          _buildCustomAppBar(context),
          32.h.verticalSpace,
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              children: [
                _addProfilePic(theme),
                12.h.verticalSpace,
                _editProfileForm(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        20.w.horizontalSpace,
        AppBackButton(
          text: "back to menu",
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  Widget _addProfilePic(ThemeData theme) {
    return ImagePickerWidget(
      onImageSelected: (path) {
        setState(() {
          imagePath = path;
        });
      },
      child: Row(
        children: [
          imagePath == null
              ? ClipOval(
                  child: Image.network(
                    "https://www.homework.ws/${session.user.id}",
                    height: 50.r,
                    width: 50.r,
                    loadingBuilder: (context, child, loadingProgress) =>
                        const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorBuilder: (context, error, stackTrace) => AppImage(
                      radius: 25.r,
                      file: imagePath,
                      boxFit: BoxFit.cover,
                      assetPath: Assets.imagesProfilePlaceholder,
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              : AppImage(
                  radius: 25.r,
                  file: imagePath,
                  boxFit: BoxFit.cover,
                  assetPath: Assets.imagesProfilePlaceholder,
                ),
          12.w.horizontalSpace,
          Text(
            "${imagePath == null ? "add" : "replace"} profile image",
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.spMin,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editProfileForm(ThemeData theme) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(color: Colors.black.withOpacity(.25))),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.h.verticalSpace,
            editableField(
              theme,
              onChanged: () {
                setState(() {
                  firstName = false;
                });
              },
              child: AppTextField(
                controller: firstNameController,
                focusNode: firstNameNode,
                validator: firstNameValidator.call,
                label: 'first name',
                hintText: 'first name',
                readOnly: firstName,
                textInputAction: TextInputAction.next,
              ),
            ),
            12.h.verticalSpace,
            editableField(
              theme,
              onChanged: () {
                setState(() {
                  lastName = false;
                });
              },
              child: AppTextField(
                controller: lastNameController,
                focusNode: lastNameNode,
                validator: lastNameValidator.call,
                label: 'last name',
                hintText: 'last name',
                readOnly: lastName,
                textInputAction: TextInputAction.next,
              ),
            ),
            12.h.verticalSpace,
            editableField(
              theme,
              onChanged: () {
                setState(() {
                  email = false;
                });
              },
              child: AppTextField(
                controller: emailController,
                focusNode: emailNode,
                validator: emailValidator.call,
                label: 'email',
                readOnly: email,
                hintText: 'name@email.com',
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
            ),
            12.h.verticalSpace,
            editableField(
              theme,
              onChanged: () {
                setState(() {
                  phone = false;
                });
              },
              child: AppTextField(
                controller: phoneController,
                focusNode: phoneNode,
                keyboardType: TextInputType.number,
                validator: phoneValidator.call,
                label: 'phone',
                hintText: '###-###-####',
                readOnly: phone,
                textInputAction: TextInputAction.next,
              ),
            ),
            10.h.verticalSpace,
            Observer(builder: (context) {
              var isLoading = authStore.isLoading;
              return PrimaryButton(
                isLoading: isLoading,
                text: "update profile",
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    if (imagePath != null) {
                      authStore.updateProfileWithImage(
                          firstNameController.text.trim(),
                          lastNameController.text.trim(),
                          emailController.text.trim(),
                          phoneController.text.trim(),
                          File(imagePath!));
                    } else {
                      var apiRequest = {
                        "firstName": firstNameController.text.trim(),
                        "lastName": lastNameController.text.trim(),
                        "email": emailController.text.trim(),
                        "phone": phoneController.text.trim()
                      };
                      authStore.updateProfile(apiRequest);
                    }
                  }
                },
              );
            }),
            12.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget editableField(ThemeData theme,
      {required Widget child, VoidCallback? onChanged}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: child),
        4.w.horizontalSpace,
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: TextButton(
            onPressed: onChanged,
            child: Text(
              "edit",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.spMin,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        )
      ],
    );
  }
}
