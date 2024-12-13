import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsOfServiceWidget extends StatefulWidget {
  final bool isEdit;

  const TermsOfServiceWidget({
    super.key,
    required this.isEdit,
  });

  @override
  State<TermsOfServiceWidget> createState() => _TermsOfServiceWidgetState();
}

class _TermsOfServiceWidgetState extends BaseState<TermsOfServiceWidget> {
  late bool firstTerm, secondTerm;

  @override
  void initState() {
    firstTerm = widget.isEdit;
    secondTerm = widget.isEdit;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(.25))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.h.verticalSpace,
          Text(
            "terms of service*",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: firstTerm,
                onChanged: (value) {
                  setState(() => firstTerm = value ?? secondTerm);
                },
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                    children: [
                      const TextSpan(text: "I agree to the homework "),
                      TextSpan(
                        text: "terms of service",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle terms of service tap
                            print("Terms of Service clicked");
                          },
                      ),
                      const TextSpan(text: " and "),
                      TextSpan(
                        text: "privacy policy",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle privacy policy tap
                            print("Privacy Policy clicked");
                          },
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: secondTerm,
                onChanged: (value) {
                  setState(() => secondTerm = value ?? secondTerm);
                },
              ),
              Expanded(
                child: Text(
                  "I acknowledge that I am going to receive a 1099 form if I make \$600 or more during the entire year.\n  •  please read about tax faqs.",
                  maxLines: 10,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(),
                ),
              ),
            ],
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  @override
  getApiData() {
    return null;
  }

  @override
  String? getError() {
    return validate() ? null : 'please agree to terms of service';
  }

  @override
  bool validate() {
    return firstTerm && secondTerm;
  }
}
