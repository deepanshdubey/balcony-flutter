import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/widget/workspace_photos_widget.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_dropdown_field.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PricingWidget extends StatefulWidget {
  const PricingWidget({
    super.key,
  });

  @override
  State<PricingWidget> createState() => _PricingWidgetState();
}

class _PricingWidgetState extends BaseState<PricingWidget> {
  late GlobalKey<FormState> formKey;
  late TextEditingController currencyController;
  late TextEditingController totalPerDayController;
  late TextEditingController additionalGuestsController;
  late TextEditingController cleaningFeeController;
  late TextEditingController cleaningFeeTypeController;
  late TextEditingController maintenanceFeeController;
  late TextEditingController maintenanceFeeTypeController;
  late TextEditingController additionalGeneralFeeController;
  late TextEditingController additionalGeneralFeeTypeController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    currencyController = TextEditingController(text: "USD");
    totalPerDayController = TextEditingController();
    additionalGuestsController = TextEditingController();
    cleaningFeeController = TextEditingController();
    cleaningFeeTypeController = TextEditingController();
    maintenanceFeeController = TextEditingController();
    maintenanceFeeTypeController = TextEditingController();
    additionalGeneralFeeController = TextEditingController();
    additionalGeneralFeeTypeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    currencyController.dispose();
    totalPerDayController.dispose();
    additionalGuestsController.dispose();
    cleaningFeeController.dispose();
    cleaningFeeTypeController.dispose();
    maintenanceFeeController.dispose();
    maintenanceFeeTypeController.dispose();
    additionalGeneralFeeController.dispose();
    additionalGeneralFeeTypeController.dispose();
    super.dispose();
  }

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

  @override
  Pricing getApiData() {
    return Pricing(
      currency: currencyController.text.trim(),
      totalPerDay: num.tryParse(totalPerDayController.text.trim()),
      cleaning: Fee(
        fee: num.tryParse(cleaningFeeController.text.trim()),
        type: cleaningFeeTypeController.text.trim(),
      ),
      additional: Fee(
        fee: num.tryParse(additionalGeneralFeeController.text.trim()),
        type: additionalGeneralFeeTypeController.text.trim(),
      ),
      maintenance: Fee(
        fee: num.tryParse(maintenanceFeeController.text.trim()),
        type: maintenanceFeeTypeController.text.trim(),
      ),
    );
  }

  @override
  String? getError() {
    return null;
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() == true;
  }

  @override
  int additionalGuests() {
    return int.tryParse(additionalGuestsController.text.trim()) ?? super.additionalGuests();
  }
}
