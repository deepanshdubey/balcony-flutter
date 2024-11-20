import 'package:balcony/ui/home/ui/tabs/stay/rant_payment_details_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TenantApplicationPage extends StatefulWidget {
  const TenantApplicationPage({super.key});

  @override
  State<TenantApplicationPage> createState() => _TenantApplicationPageState();
}

class _TenantApplicationPageState extends State<TenantApplicationPage> {
  late final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController socialSecurityController;
  late FocusNode firstNameNode;
  late FocusNode lastNameNode;
  late FocusNode phoneNumberNode;
  late FocusNode emailNode;
  late FocusNode socialSecurityNode;
  String? selectedTitle;
  final List<String> titles = ['232.', '232', '343'];

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    socialSecurityController = TextEditingController();
    firstNameNode = FocusNode();
    lastNameNode = FocusNode();
    phoneNumberNode = FocusNode();
    emailNode = FocusNode();
    socialSecurityNode = FocusNode();
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start ,
          children: [
            10.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
              child: Text(
                "hello {first name} we need a few information about you.",
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
                    items: titles
                        .map((title) => DropdownMenuItem<String>(
                              value: title,
                              child: Text(title),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                  16.verticalSpace,
                  AppTextField(
                    controller: emailController,
                    focusNode: emailNode,
                    label: 'anticipated move-in request',
                    hintText: "01/02/2025",
                    keyboardType: TextInputType.emailAddress,
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
                  ),16.verticalSpace

                ],
              ),
            ),24.verticalSpace,
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
                  ),16.verticalSpace,
                  AgreementCheckboxes(onAllChecked: () {  },),
                  16.h.verticalSpace,

                ],
              ),
            ),
            25.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: PrimaryButton(text: "submit application", onPressed: () {

              },),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Text("**Note: If application is approved by property manager, then you will be prompted to next step(s) which is usually leasing agreement & first month rent & security.", style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 11.spMin,
                fontWeight: FontWeight.w800,
                color: appColor.primaryColor,
              ),),
            ),30.verticalSpace
          ],
        ),
      ),
    );
  }
}
