import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_dropdown_field.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingWidget extends StatelessWidget {
  const PricingWidget({
    super.key,
    required this.formKey,
    required this.currencyController,
    required this.totalPerDayController,
    required this.additionalGuestsController,
    required this.cleaningFeeController,
    required this.cleaningFeeTypeController,
    required this.maintenanceFeeController,
    required this.maintenanceFeeTypeController,
    required this.additionalGeneralFeeController,
    required this.additionalGeneralFeeTypeController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController currencyController;
  final TextEditingController totalPerDayController;
  final TextEditingController additionalGuestsController;
  final TextEditingController cleaningFeeController;
  final TextEditingController cleaningFeeTypeController;
  final TextEditingController maintenanceFeeController;
  final TextEditingController maintenanceFeeTypeController;
  final TextEditingController additionalGeneralFeeController;
  final TextEditingController additionalGeneralFeeTypeController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
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
              "pricing*",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppDropdownField<String>(
              controller: currencyController,
              label: 'currency',
              hintText: 'choose a currency',
              items: const ['USD'],
              itemLabel: (item) => item,
              onItemSelected: (item) {},
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: totalPerDayController,
              label: 'total per day',
              hintText: 'price',
              validator: requiredValidator.call,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: additionalGuestsController,
              label: 'additional guests per booking',
              hintText: '2..',
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: requiredValidator.call,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            Text(
              "additional charges",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            Text(
              "**Note: We suggest you do not include cleaning, maintenance, or any other fees on top of the subtotal per booking as users may be less inclined to book the workspace.\n• However, we understand so please do add additional fees if you like.",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 13.spMin,
                  ),
            ),
            16.h.verticalSpace,
            Row(
              children: [
                Flexible(
                  flex: 11,
                  child: AppTextField(
                    controller: cleaningFeeController,
                    label: 'cleaning fee',
                    hintText: '1..',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                20.w.horizontalSpace,
                Flexible(
                  flex: 9,
                  child: AppDropdownField(
                    controller: cleaningFeeTypeController,
                    label: 'fee type',
                    hintText: '1..',
                    items: const ['daily', 'weekly', 'monthly'],
                    itemLabel: (item) => item,
                    onItemSelected: (item) {},
                  ),
                ),
              ],
            ),
            16.h.verticalSpace,
            Row(
              children: [
                Flexible(
                  flex: 11,
                  child: AppTextField(
                    controller: maintenanceFeeController,
                    label: 'maintenance fee',
                    hintText: '2..',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                20.w.horizontalSpace,
                Flexible(
                  flex: 9,
                  child: AppDropdownField(
                    controller: maintenanceFeeController,
                    label: 'fee type',
                    hintText: '2..',
                    items: const ['daily', 'weekly', 'monthly'],
                    itemLabel: (item) => item,
                    onItemSelected: (item) {},
                  ),
                ),
              ],
            ),
            16.h.verticalSpace,
            Row(
              children: [
                Flexible(
                  flex: 11,
                  child: AppTextField(
                    controller: additionalGeneralFeeController,
                    label: 'additional general fee',
                    hintText: '3..',
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                    ],
                    keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                  ),
                ),
                20.w.horizontalSpace,
                Flexible(
                  flex: 9,
                  child: AppDropdownField(
                    controller: additionalGeneralFeeTypeController,
                    label: 'fee type',
                    hintText: '3..',
                    items: const ['daily', 'weekly', 'monthly'],
                    itemLabel: (item) => item,
                    onItemSelected: (item) {},
                  ),
                ),
              ],
            ),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }
}
