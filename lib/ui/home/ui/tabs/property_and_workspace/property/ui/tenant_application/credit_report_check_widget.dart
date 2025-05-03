import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/store/address_store.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';

class CreditReportCheckWidget extends StatefulWidget {
  const CreditReportCheckWidget({super.key});

  @override
  State<CreditReportCheckWidget> createState() =>
      _CreditReportCheckWidgetState();
}

class _CreditReportCheckWidgetState extends BaseState<CreditReportCheckWidget> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController countryIdController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    countryIdController = TextEditingController();
    countryController = TextEditingController();
  }

  @override
  void dispose() {
    countryIdController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Map<String, dynamic> getApiData() {
    return {
      "country_id": countryIdController.text,
      "country": countryController.text,
    };
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border:
              Border.all(color: Theme.of(context).primaryColor.withAlpha(60))),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            Text(
              "credit report check",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            Observer(builder: (_) {
              final countries = addressStore.countries ?? [];
              return AppDropdownField<csc.Country>(
                controller: countryController,
                label: 'country of residence*',
                hintText: 'pick a country',
                items: countries,
                validator: requiredValidator.call,
                itemLabel: (c) => c.name.toLowerCase(),
                onItemSelected: (c) => addressStore.fetchStates(c.isoCode),
              );
            }),
            16.h.verticalSpace,
            AppTextField(
              controller: countryIdController,
              label: 'country id # (SSN,NIN,etc.)',
              hintText: 'security no.',
            ),
            12.h.verticalSpace,
            Divider(
              color: appColor.primaryColor,
              thickness: 1.h,
            ),
            12.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  String? getError() {
    return null;
  }
}
