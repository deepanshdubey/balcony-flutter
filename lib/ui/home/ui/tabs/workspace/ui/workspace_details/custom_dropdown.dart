import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> items;

  CustomDropdown({required this.title, required this.items});

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: appColor.primaryColor.withOpacity(0.25),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  topRight: Radius.circular(8.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 12.spMin,
                        ),
                  ),
                  Icon(
                    _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: appColor.primaryColor,
                  ),
                ],
              ),
            ),
          ),

          // List of Items (expanded/collapsed)
          if (_isExpanded)
            Column(
              children: widget.items.map((item) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        item['icon'],
                        size: 16.r,
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
                    Divider(
                      color: appColor.primaryColor,
                      thickness: 0.5,
                    ),
                  ],
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
