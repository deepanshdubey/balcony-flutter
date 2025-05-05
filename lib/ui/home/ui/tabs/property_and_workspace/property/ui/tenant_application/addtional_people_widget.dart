import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/addtional_form.dart';
import 'package:homework/widget/app_image.dart';

class AdditionalPeopleWidget extends StatefulWidget {
  const AdditionalPeopleWidget({super.key});

  @override
  State<AdditionalPeopleWidget> createState() => _AdditionalPeopleWidgetState();
}

class _AdditionalPeopleWidgetState extends BaseState<AdditionalPeopleWidget> {
  final List<AdditionalForm> additionalForm = [];
  final List<GlobalKey<BaseState>> additionalFormKeys = [
    GlobalKey<BaseState>()
  ];

  @override
  void initState() {
    super.initState();
    additionalForm.add(AdditionalForm(key: additionalFormKeys.first));
  }

  void _addNewForm() {
    if (additionalForm.length < 4) {
      setState(() {
        var key = GlobalKey<BaseState>();
        additionalFormKeys.add(key);
        additionalForm.add(AdditionalForm(
          key: key,
        ));
      });
    }
  }

  void _removeForm(int index) {
    if (additionalForm.length > 1) {
      setState(() {
        additionalFormKeys.removeAt(index);
        additionalForm.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border:
            Border.all(color: Theme.of(context).primaryColor.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.h.verticalSpace,
          Text(
            "add additional people",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.spMin,
                ),
          ),
          Text(
            "Please note: Most U.S. property teams require a background check for all additional occupants aged 18 or older. If the property team requests that you add them. kindly provide their information below. They are expected to receive an email with a link to complete their application. After adding & send, please request them to check their email inbox, spam etc, etc Application fee applies",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 12.spMin,
                ),
          ),
          16.h.verticalSpace,
          ...additionalForm.asMap().entries.map((entry) {
            final index = entry.key;
            final form = entry.value;
            return Stack(
              children: [
                form,
                if (index != 0)
                  Positioned(
                    top: -12,
                    right: 8,
                    child: IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeForm(index),
                    ),
                  ),
              ],
            );
          }),
          if (additionalForm.length < 4)
            InkWell(
              onTap: _addNewForm,
              child: Row(
                children: [
                  AppImage(
                    height: 30.r,
                    width: 30.r,
                    assetPath: Assets.imagesLargePlus,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "add additional members",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(decoration: TextDecoration.underline),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  @override
  List getApiData() {
    return additionalFormKeys
        .map(
          (e) => e.currentState?.getApiData(),
        )
        .toList();
  }

  @override
  bool validate() {
    bool isValid = true;
    for (final key in additionalFormKeys) {
      if (key.currentState?.validate() == false) {
        isValid = false;
      }
    }
    return isValid;
  }

  @override
  String? getError() {
    return null;
  }
}
