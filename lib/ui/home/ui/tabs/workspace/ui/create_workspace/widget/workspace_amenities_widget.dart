import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/workspace/ui/create_workspace/model/amenities_item.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkspaceAmenitiesWidget extends StatefulWidget {
  final List<AmenitiesItem> amenities;
  final String? otherAmenities;

  const WorkspaceAmenitiesWidget({
    super.key,
    required this.amenities,
    this.otherAmenities,
  });

  @override
  State<WorkspaceAmenitiesWidget> createState() =>
      _WorkspaceAmenitiesWidgetState();
}

class _WorkspaceAmenitiesWidgetState extends State<WorkspaceAmenitiesWidget> {
  late String? otherAmenities;
  late TextEditingController otherAmenitiesController;

  @override
  void initState() {
    otherAmenities = widget.otherAmenities;
    otherAmenitiesController = TextEditingController(text: otherAmenities);
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
            "workspace amenities",
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
          otherAmenitiesWidget(),
          8.h.verticalSpace,
          if (otherAmenities != null)
            AppTextField(
              controller: otherAmenitiesController,
              label: "enter amenity",
              hintText: 'type the amenity name',
            ),
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

  Widget otherAmenitiesWidget() {
    return GestureDetector(
        onTap: () {
          setState(() {
            if (otherAmenities == null) {
              otherAmenities = "";
            } else {
              otherAmenitiesController.text = "";
              otherAmenities = null;
            }
          });
        },
        child: Row(
          children: [
            AppImage(
              height: 30.r,
              width: 30.r,
              assetPath: otherAmenities == null
                  ? Assets.imagesLargePlus
                  : Assets.imagesLargeMinus,
            ),
            16.w.horizontalSpace,
            Expanded(
              child: Text(
                otherAmenities == null
                    ? "not listed? manually add an amenity."
                    : "remove",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            )
          ],
        ));
  }
}
