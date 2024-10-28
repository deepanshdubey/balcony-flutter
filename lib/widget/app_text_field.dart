import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText, showLabelAboveField, readOnly;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final InputDecoration? inputDecoration;
  final int? maxLength;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffixIcon,
    this.showLabelAboveField = true,
    this.prefixIcon,
    this.onChanged,
    this.inputDecoration,
    this.readOnly = false,
    this.onTap,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return showLabelAboveField
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 14.spMin, fontWeight: FontWeight.w500),
              ),
              6.h.verticalSpace,
              field(context)
            ],
          )
        : field(context);
    ;
  }

  Widget field(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly,
      onTap: onTap,
      maxLength: maxLength,
      decoration: inputDecoration ??
          InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 16.w,
              ),
              labelText: hintText,
              hintText: hintText,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              floatingLabelBehavior: FloatingLabelBehavior.never),
      keyboardType: keyboardType,
      obscureText: obscureText,
      obscuringCharacter: "*",
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
    );
  }
}
