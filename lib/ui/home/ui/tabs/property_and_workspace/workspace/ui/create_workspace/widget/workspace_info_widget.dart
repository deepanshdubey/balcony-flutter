import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/values/validators.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceInfoWidget extends StatefulWidget {
  const WorkspaceInfoWidget({super.key});

  @override
  State<WorkspaceInfoWidget> createState() => _WorkspaceInfoWidgetState();
}

class _WorkspaceInfoWidgetState extends BaseState<WorkspaceInfoWidget> {
  late GlobalKey<FormState> formKey;
  late TextEditingController workspaceNameController;
  late TextEditingController floorController;
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryController;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    workspaceNameController = TextEditingController();
    floorController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    formKey.currentState?.dispose();
    workspaceNameController.dispose();
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
              "workspace info*",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.spMin,
                  ),
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: workspaceNameController,
              label: 'name of workspace',
              hintText: 'the square',
              validator: workspaceNameValidator.call,
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
            16.h.verticalSpace,
            AppTextField(
              controller: floorController,
              validator: addressValidator.call,
              label: 'floor, apt., etc.',
              hintText: 'floor 2',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: cityController,
              validator: cityValidator.call,
              label: 'city',
              hintText: 'new york city',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: stateController,
              keyboardType: TextInputType.text,
              validator: stateValidator.call,
              label: 'state',
              hintText: 'new york',
              textInputAction: TextInputAction.next,
            ),
            16.h.verticalSpace,
            AppTextField(
              controller: countryController,
              validator: countryValidator.call,
              label: 'country',
              hintText: 'united states',
            ),
            16.h.verticalSpace,
          ],
        ),
      ),
    );
  }

  @override
  Info getApiData() {
    return Info(
      name: workspaceNameController.text.trim(),
      address: addressController.text.trim(),
      floor: floorController.text.trim(),
      city: cityController.text.trim(),
      state: stateController.text.trim(),
      country: countryController.text.trim(),
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


}
