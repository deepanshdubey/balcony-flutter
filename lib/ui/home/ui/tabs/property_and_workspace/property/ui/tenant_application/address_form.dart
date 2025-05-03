import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:country_state_city/models/state.dart' as s;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/store/address_store.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';

class AddressForm extends StatefulWidget {
  final Info? existingAddress;

  const AddressForm({super.key, this.existingAddress});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController unitController;
  late TextEditingController streetController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;

  @override
  void initState() {
    super.initState();
    unitController = TextEditingController(text: widget.existingAddress?.floor);
    streetController =
        TextEditingController(text: widget.existingAddress?.address);
    cityController = TextEditingController(text: widget.existingAddress?.city);
    stateController =
        TextEditingController(text: widget.existingAddress?.state);
    countryController =
        TextEditingController(text: widget.existingAddress?.country);
  }

  @override
  void dispose() {
    unitController.dispose();
    streetController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
    super.dispose();
  }

  Info getApiData() {
    return Info(
      floor: unitController.text.trim(),
      address: streetController.text.trim(),
      city: cityController.text.trim(),
      state: stateController.text.trim(),
      country: countryController.text.trim(),
      summary: 'a',
    );
  }

  bool validate() {
    return formKey.currentState?.validate() ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: streetController,
            label: 'street',
            hintText: '..',
            validator: addressValidator.call,
          ),
          12.h.verticalSpace,
          LayoutBuilder(
            builder: (context, constraints) {
              // compute half of the available width minus spacing
              final itemWidth = (constraints.maxWidth - 12.w) / 2;

              return Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children: [
                  // Country dropdown
                  SizedBox(
                    width: itemWidth,
                    child: Observer(builder: (_) {
                      final countries = addressStore.countries ?? [];
                      return AppDropdownField<csc.Country>(
                        controller: countryController,
                        label: 'country',
                        hintText: 'pick a country',
                        items: countries,
                        itemLabel: (c) => c.name.toLowerCase(),
                        onItemSelected: (c) =>
                            addressStore.fetchStates(c.isoCode),
                      );
                    }),
                  ),

                  // State dropdown
                  SizedBox(
                    width: itemWidth,
                    child: Observer(builder: (_) {
                      final states = addressStore.states ?? [];
                      return AppDropdownField<s.State>(
                        controller: stateController,
                        label: 'state',
                        hintText: '..',
                        items: states,
                        itemLabel: (s) => s.name.toLowerCase(),
                        onItemSelected: (s) =>
                            addressStore.fetchCities(s.isoCode),
                      );
                    }),
                  ),

                  // City dropdown
                  SizedBox(
                    width: itemWidth,
                    child: Observer(builder: (_) {
                      final cities = addressStore.cities ?? [];
                      return AppDropdownField<csc.City>(
                        controller: cityController,
                        label: 'city',
                        hintText: '..',
                        items: cities,
                        itemLabel: (c) => c.name.toLowerCase(),
                        onItemSelected: (c) {},
                      );
                    }),
                  ),

                  // Unit text field
                  SizedBox(
                    width: itemWidth,
                    child: AppTextField(
                      controller: unitController,
                      label: 'unit',
                      hintText: '..',
                      validator: addressValidator.call,
                    ),
                  ),
                ],
              );
            },
          ),
          12.h.verticalSpace,
          Divider(
            color: appColor.primaryColor,
            thickness: 1.h,
          ),
          12.h.verticalSpace,
        ],
      ),
    );
  }
}
