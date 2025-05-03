import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/emergency_from.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/emergency_from.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/tenant_application/emergency_from.dart';
import 'package:homework/widget/app_image.dart';

import 'address_form.dart';

class EmergencyContactWidget extends StatefulWidget {
  const EmergencyContactWidget({super.key});

  @override
  State<EmergencyContactWidget> createState() => _EmergencyContactWidgetState();
}

class _EmergencyContactWidgetState extends BaseState<EmergencyContactWidget> {
  final List<EmergencyForm> emergencyContacts = [];

  @override
  void initState() {
    super.initState();
    emergencyContacts.add(EmergencyForm());
  }

  void _addNewForm() {
    if (emergencyContacts.length < 4) {
      setState(() {
        emergencyContacts.add(EmergencyForm(
          key: Key(emergencyContacts.length.toString()),
        ));
      });
    }
  }

  void _removeForm(int index) {
    if (emergencyContacts.length > 1) {
      setState(() {
        emergencyContacts.removeAt(index);
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
            "emergency contact",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          ...emergencyContacts.asMap().entries.map((entry) {
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
          }).toList(),
          if (emergencyContacts.length < 4)
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
                          "add more",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(decoration: TextDecoration.underline),
                        ),
                        2.h.verticalSpace,
                        Text(
                          "(up to 3 prior contacts if applicable)",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 9.spMin),
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
  Info getApiData() {
    return Info();
  }

  List<Info> getAllAddresses() {
    return [];
  }

  @override
  bool validate() {
    bool isValid = true;
    for (final form in emergencyContacts) {
      /*if (!form.validate()) {
        isValid = false;
      }*/
    }
    return isValid;
  }

  @override
  String? getError() {
    return null;
  }
}
