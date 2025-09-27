import 'package:homework/data/model/response/workspace_data.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/store/address_store.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/validators.dart';
import 'package:homework/widget/app_dropdown_field.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:country_state_city/country_state_city.dart' as csc;
import 'package:country_state_city/models/state.dart' as s;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressWidget extends StatefulWidget {
  final bool isWorkSpace;
  final Info? existingAddress;

  const AddressWidget({super.key, this.isWorkSpace = true, this.existingAddress});

  @override
  State<AddressWidget> createState() => _AddressWidgetState();
}

class _AddressWidgetState extends BaseState<AddressWidget> {
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController floorController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.existingAddress?.name );
    floorController = TextEditingController(text: widget.existingAddress?.floor );
    addressController = TextEditingController(text: widget.existingAddress?.address );
    cityController = TextEditingController(text: widget.existingAddress?.city );
    stateController = TextEditingController(text: widget.existingAddress?.state );
    countryController = TextEditingController(text: widget.existingAddress?.country );
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    nameController.dispose();
    floorController.dispose();
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
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
              widget.isWorkSpace ? "workspace amenities*" : 'rental info*',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: nameController,
              label: widget.isWorkSpace
                  ? 'name of workspace'
                  : 'property name if any',
              hintText: 'the square',
              validator:
                  widget.isWorkSpace ? workspaceNameValidator.call : null,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: addressController,
              validator: addressValidator.call,
              label: 'address',
              hintText: '123 address..',
              textInputAction: TextInputAction.next,
            ),
            if (widget.isWorkSpace) 16.h.verticalSpace,
            if (widget.isWorkSpace)
              AppTextField(
                controller: floorController,
                validator: addressValidator.call,
                label: 'floor, apt., etc.',
                hintText: 'floor 2',
                textInputAction: TextInputAction.next,
              ),
            16.h.verticalSpace,
            Observer(builder: (context) {
              var countries = addressStore.countries;
              return AppDropdownField(
                controller: countryController,
                label: 'country',
                hintText: 'united states',
                items: countries ?? <csc.Country>[],
                itemLabel: (csc.Country c) => c.name.toLowerCase(),
                onItemSelected: (csc.Country c) {
                  addressStore.fetchStates(c.isoCode);
                },
              );
            }),
            16.h.verticalSpace,
            Observer(builder: (context) {
              var states = addressStore.states;
              return AppDropdownField<s.State>(
                controller: stateController,
                label: 'state',
                hintText: 'new york',
                items: states ?? <s.State>[],
                itemLabel: (s.State c) => c.name.toLowerCase(),
                onItemSelected: (s.State c) {
                  addressStore.fetchCities(c.isoCode);
                },
              );
            }),
            16.h.verticalSpace,
            Observer(builder: (context) {
              var cities = addressStore.cities;
              return AppDropdownField<csc.City>(
                controller: cityController,
                label: 'city',
                hintText: 'new york city',
                items: cities ?? [],
                itemLabel: (p0) => p0.name.toLowerCase(),
                onItemSelected: (p0) {},
              );
            }),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  Info getApiData() {
    return Info(
        name: nameController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        state: stateController.text.trim(),
        country: countryController.text.trim(),
        summary: 'a');
  }

  @override
  String? getError() {
    return null;
  }

  @override
  bool validate() {
    return formKey.currentState?.validate() == true;
  }
}
