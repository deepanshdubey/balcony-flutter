import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/property_data.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/support_tickets/widget/section_title.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/property/store/property_store.dart';
import 'package:homework/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/widget/property_row_widget.dart';
import 'package:homework/widget/app_image.dart';

/// Stateless widget: all data & callbacks come from the parent.
class PropertyManagerWidget extends StatelessWidget {
  /// The list of properties to show (can be null or empty).
  final List<PropertyData>? properties;

  /// Whether we're currently loading.
  final bool isLoading;

  /// Called when the user taps "add new property".
  final VoidCallback onAddNew;

  /// Called when the user taps delete on a row.
  final ValueChanged<String> onDelete;

  /// Called when the user taps update on a row.
  final ValueChanged<PropertyData> onUpdate;

  const PropertyManagerWidget({
    super.key,
    required this.properties,
    required this.isLoading,
    required this.onAddNew,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "property manager", subtitle: ""),
        SizedBox(height: 8.h),
        _buildAddNewRow(context),
        SizedBox(height: 8.h),
        _buildTable(context),
      ],
    );
  }

  Widget _buildAddNewRow(BuildContext context) {
    return InkWell(
      onTap: onAddNew,
      child: Row(
        children: [
          AppImage(
            height: 30.r,
            width: 30.r,
            assetPath: Assets.imagesLargePlus,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              "add new property",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        children: [
          _buildHeader(context),
          if (isLoading)
            Padding(
              padding: EdgeInsets.all(20.r),
              child: const CircularProgressIndicator(),
            )
          else if (properties != null && properties!.isNotEmpty)
            _buildList()
          else
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Center(child: const Text('no properties available.')),
            ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: Colors.black54);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.r),
      child: Row(
        children: [
          Expanded(flex: 1, child: Checkbox(value: false, onChanged: (_) {})),
          Expanded(flex: 3, child: Text('property', style: style)),
          Expanded(flex: 2, child: Center(child: Text('status', style: style))),
          Expanded(
              flex: 3,
              child: Center(child: Text('update space', style: style))),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      itemCount: properties!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      separatorBuilder: (_, __) => Divider(height: 1.h, color: Colors.black26),
      itemBuilder: (context, index) {
        final property = properties![index];
        return PropertyRowWidget(
          property: property,
          onDelete: () => onDelete(property.id.toString()),
          onUpdate: () => onUpdate(property),
        );
      },
    );
  }
}
