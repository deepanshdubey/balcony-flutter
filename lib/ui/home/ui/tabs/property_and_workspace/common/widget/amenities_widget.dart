import 'package:homework/core/locator/locator.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/common/base_state.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/create_workspace/model/amenities_item.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/widget/primary_button.dart';

class AmenitiesWidget extends StatefulWidget {
  final bool isWorkspace;
  final List<AmenitiesItem> amenities;
  final String? otherAmenities;

  const AmenitiesWidget({
    super.key,
    required this.amenities,
    this.otherAmenities,
    this.isWorkspace = true,
  });

  @override
  State<AmenitiesWidget> createState() => _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends BaseState<AmenitiesWidget> {
  late TextEditingController otherAmenitiesController;

  @override
  void initState() {
    otherAmenitiesController = TextEditingController();
    super.initState();
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
            widget.isWorkspace ? "workspace amenities" : "property amenities",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 24.spMin,
            ),
          ),
          16.h.verticalSpace,
          Column(
            children: widget.amenities
                .map(
                  (amenity) => amenityItem(amenity),
            )
                .toList(),
          ),
          16.h.verticalSpace,
          addAmenityField(),
          16.h.verticalSpace,
        ],
      ),
    );
  }

  Widget amenityItem(AmenitiesItem amenity) {
    return StatefulBuilder(
      builder: (context, setState) => Row(
        children: [
          Checkbox(
            value: amenity.isChecked,
            onChanged: (value) {
              setState(() {
                amenity.isChecked = value ?? amenity.isChecked;
              });
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          8.w.horizontalSpace,
          AppImage(
            height: 16.r,
            width: 16.r,
            assetPath: amenity.image,
          ),
          12.w.horizontalSpace,
          Expanded(
            child: Text(
              amenity.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(),
            ),
          ),
        ],
      ),
    );
  }

  Widget addAmenityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          controller: otherAmenitiesController,
          label: "Enter amenity",
          hintText: 'Type the amenity name',
        ),
        8.h.verticalSpace,
        PrimaryButton(
          text: "Add Amenity",
          onPressed: () {
            final newAmenity = otherAmenitiesController.text.trim();
            if (newAmenity.isNotEmpty) {
              setState(() {
                widget.amenities.add(AmenitiesItem(name: newAmenity, image: Assets.imagesLargePlus, ));
                otherAmenitiesController.clear();
              });
            }
          },
        ),
      ],
    );
  }

  @override
  List<String> getApiData() {
    List<String> checked = widget.amenities
        .where(
          (element) => element.isChecked,
    )
        .map(
          (e) => e.name,
    )
        .toList();
    return checked;
  }

  @override
  String? getError() {
    return null;
  }

  @override
  bool validate() {
    return true;
  }
}
