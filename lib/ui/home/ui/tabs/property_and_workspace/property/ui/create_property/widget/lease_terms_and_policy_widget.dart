import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/file_picker_widget.dart';

class LeaseTermsAndPolicyWidget extends StatefulWidget {
  const LeaseTermsAndPolicyWidget({
    super.key,
  });

  @override
  State<LeaseTermsAndPolicyWidget> createState() =>
      _LeaseTermsAndPolicyWidgetState();
}

class _LeaseTermsAndPolicyWidgetState
    extends BaseState<LeaseTermsAndPolicyWidget> {
  String? selectedFilePath;

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
            "leasing terms & policy",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          8.h.verticalSpace,
          Text(
            'For the purpose of having prospect tenants applicants see your leasing agreements & policy, please upload this doc so that they may review when applying.',
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 14.spMin,
              color: theme.primaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          12.h.verticalSpace,
          Text(
            "upload leasing policy doc (pdf, word, etc.)*",
            style: theme.textTheme.titleMedium,
          ),
          8.h.verticalSpace,
          FilePickerWidget(
              onFileSelected: (p0) {
                setState(() {
                  selectedFilePath = p0;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.r)),
                  border: Border.all(color: Theme.of(context).primaryColor),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.upload_file,
                      color: theme.primaryColor,
                    ),
                    8.w.horizontalSpace,
                    Text(
                      "upload new doc.",
                      style: theme.textTheme.titleMedium,
                    ),
                  ],
                ),
              )),
          2.h.verticalSpace,
          if (selectedFilePath != null)
            Text(
              "selected file: ${selectedFilePath?.split("/").lastOrNull}",
              style: theme.textTheme.titleMedium,
            ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  @override
  getApiData() {
    return selectedFilePath;
  }

  @override
  String? getError() {
    return validate() ? null : 'please upload lease terms and privacy policy';
  }

  @override
  bool validate() {
    return selectedFilePath != null;
  }
}
