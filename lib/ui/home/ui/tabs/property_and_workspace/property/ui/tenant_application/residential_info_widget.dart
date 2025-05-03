import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/widget/app_image.dart';

import 'address_form.dart';

class ResidentialInfoWidget extends StatefulWidget {
  const ResidentialInfoWidget({super.key});

  @override
  State<ResidentialInfoWidget> createState() => _ResidentialInfoWidgetState();
}

class _ResidentialInfoWidgetState extends BaseState<ResidentialInfoWidget> {
  final List<AddressForm> addressForms = [];

  @override
  void initState() {
    super.initState();
    addressForms.add(AddressForm());
  }

  void _addNewForm() {
    if (addressForms.length < 4) {
      setState(() {
        addressForms.add(AddressForm(
          key: Key(addressForms.length.toString()),
        ));
      });
    }
  }

  void _removeForm(int index) {
    if (addressForms.length > 1) {
      setState(() {
        addressForms.removeAt(index);
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
            "residential history**",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          ...addressForms.asMap().entries.map((entry) {
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
          if (addressForms.length < 4)
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
                          "(up to 3 prior addresses if applicable)",
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
    for (final form in addressForms) {
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
