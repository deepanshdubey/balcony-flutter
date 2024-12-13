import 'dart:io';

import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/ui/create_property/model/unit_item.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:homework/widget/image_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitListWidget extends StatefulWidget {
  const UnitListWidget({
    super.key,
  });

  @override
  State<UnitListWidget> createState() => _UnitListWidgetState();
}

class _UnitListWidgetState extends BaseState<UnitListWidget> {
  late GlobalKey<FormState> formKey;
  late TextEditingController currencyController;
  late TextEditingController searchController;
  int maxUnits = 6;

  List<UnitItem> unitList = [UnitItem()];

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    currencyController = TextEditingController(text: "USD");
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    currencyController.dispose();
    searchController.dispose();
    super.dispose();
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
            "unit list*",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: searchController,
                  label: '',
                  showLabelAboveField: false,
                  hintText: 'filter search',
                ),
              ),
              16.w.horizontalSpace,
              Expanded(
                child: AppDropdownField<String>(
                  controller: currencyController,
                  label: 'currency',
                  showLabelAboveField: false,
                  hintText: 'currency',
                  items: const ['USD'],
                  itemLabel: (item) => item,
                  onItemSelected: (item) {},
                ),
              ),
            ],
          ),
          16.h.verticalSpace,
          Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: unitList
                    .map(
                      (e) => unitItem(e),
                    )
                    .toList(),
              )),
          16.h.verticalSpace,
          GestureDetector(
            onTap: () {
              if (unitList.length < maxUnits) {
                setState(() {
                  unitList.add(UnitItem());
                });
              }
            },
            child: Row(
              children: [
                Opacity(
                  opacity: unitList.length < maxUnits ? 1 : .2,
                  child: AppImage(
                    height: 30.r,
                    width: 30.r,
                    assetPath: Assets.imagesLargePlus,
                  ),
                ),
                16.w.horizontalSpace,
                Expanded(
                  child: Text(
                    'add more',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: TextDecoration.underline,
                        color: theme.primaryColor
                            .withOpacity(unitList.length <= maxUnits ? 1 : .2)),
                  ),
                )
              ],
            ),
          ),
          16.h.verticalSpace,
          SizedBox(
            width: context.width * .6,
            child: Text(
              '3 more slots left, but you can update plan for more units if you like',
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.spMin,
                color: theme.primaryColor,
              ),
            ),
          ),
          16.h.verticalSpace,
          SizedBox(
            width: context.width * .4,
            child: AppOutlinedButton(
              text: 'update plan',
              onPressed: () {},
            ),
          ),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  @override
  Map<String, dynamic> getApiData() {
    return  {
      'floor_plan_images' : unitList.where((element) => element.floorImage != null,).map((e) => File(e.floorImage!),).toList(),
      'currency' : currencyController.text.trim(),
      'units' : unitList.map((e) =>  {
        "unit": e.unitController.text.trim(),
        "price": e.priceController.text.trim(),
        "beds": e.bedController.text.trim(),
        "baths": e.bathController.text.trim(),
        "isAvailable": true
      },).toList()
    };
  }

  @override
  String? getError() {
    return null;
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() == true;
  }

  Widget unitItem(UnitItem e) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        12.h.verticalSpace,
        Row(
          children: [
            Flexible(
              flex: 6,
              child: AppTextField(
                controller: e.unitController,
                label: 'unit #',
                hintText: '##',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: requiredValidator.call,
              ),
            ),
            16.w.horizontalSpace,
            Flexible(
              flex: 4,
              child: AppTextField(
                controller: e.priceController,
                hintText: '\$\$',
                label: 'price',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                ],
                validator: requiredValidator.call,
              ),
            ),
          ],
        ),
        10.h.verticalSpace,
        Row(
          children: [
            Flexible(
              flex: 3,
              child: AppTextField(
                controller: e.bedController,
                label: 'beds',
                hintText: '##',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: requiredValidator.call,
              ),
            ),
            12.w.horizontalSpace,
            Flexible(
              flex: 2,
              child: AppTextField(
                controller: e.bathController,
                label: 'bath',
                hintText: '##',
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: requiredValidator.call,
              ),
            ),
            12.w.horizontalSpace,
            Flexible(
                flex: 5,
                child: ImagePickerWidget(
                  onImageSelected: (p0) {
                    setState(() {
                      e.floorImage = p0;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Row(
                      children: [
                        AppImage(
                          radius: 12.r,
                          boxFit: BoxFit.cover,
                          assetPath: Assets.imagesLargePlus,
                        ),
                        12.w.horizontalSpace,
                        Expanded(
                          child: Text(
                            "${e.floorImage == null ? "add" : "update"} floor plan image",
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.spMin,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 12.h),
          height: 1.h,
          color: theme.primaryColor.withOpacity(.2),
        )
      ],
    );
  }
}
