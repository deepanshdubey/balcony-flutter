
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/widget/app_outlined_button.dart';

/// Single row in the tenant table.
class TenantRowWidget extends StatelessWidget {
  final Tenants tenant;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;
  final VoidCallback onView;

  const TenantRowWidget({
    Key? key,
    required this.tenant,
    required this.isSelected,
    required this.onSelected,
    required this.onView,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = tenant.info?.firstName ?? "no name";

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 12.r),
      child: Row(
        children: [
          Checkbox(value: isSelected, onChanged: onSelected),
          Expanded(
            flex: 3,
            child: Text(name, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Expanded(
            flex: 1,
            child: AppOutlinedButton(
              padding: EdgeInsets.zero,
              style: TextStyle(fontSize: 13.spMin),
              text: "view",
              onPressed: onView,
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }
}
