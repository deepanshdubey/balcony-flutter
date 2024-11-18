import 'package:balcony/generated/assets.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> items;
  final int visibleItem ;

  CustomDropdown({required this.title, required this.items, required this.visibleItem});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
     int maxVisibleItems = widget.visibleItem; // Maximum items visible before scrolling

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: appColor.primaryColor.withOpacity(0.25),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 12.spMin,
                  ),
                ),8.horizontalSpace,
                Image.asset(Assets.imagesChevronsUpDown,height: 12.r,width: 12.r,)
              ],
            ),
          ),

          // Item List
          SizedBox(
            height: (widget.items.length > maxVisibleItems
                ? maxVisibleItems * 50.h // Estimated height per item
                : widget.items.length * 50.h) +
                8.h, // Add padding for better UX
            child: SingleChildScrollView(
              child: Column(
                children: widget.items.map((item) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          AssetHelper.getAssetForAmenity(item['title']),
                          height: 16.r,
                          width: 16.r,
                          color: appColor.primaryColor,
                        ),
                        title: Text(
                          item['title'],
                          style:
                          Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.spMin,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Color(0xffE2E8F0),
                        thickness: 0.5,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
