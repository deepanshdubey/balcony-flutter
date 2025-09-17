import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/constants.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceWidget extends StatefulWidget {
  final bool isEdit;
  final bool showLeasingPolicy;

  const TermsOfServiceWidget({
    super.key,
    required this.isEdit,
    this.showLeasingPolicy = false,
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
                            openUrl(Constants.terms);
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
                            openUrl(Constants.policy);
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
          Visibility(
            visible: !widget.showLeasingPolicy,
            child: Row(
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
          ),
          Visibility(
            visible: widget.showLeasingPolicy,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox(
                  value: secondTerm,
                  onChanged: (value) {
                    setState(() => secondTerm = value ?? secondTerm);
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      openUrl(Constants.leasing);
                    },
                    child: Text("leasing agreement & policy",
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(decoration: TextDecoration.underline)),
                  ),
                ),
              ],
            ),
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

Future<void> openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
