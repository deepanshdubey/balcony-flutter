import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDropdownField<T> extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  final List<T> items;
  final String Function(T) itemLabel;
  final T? selectedItem;
  final void Function(T) onItemSelected;
  final bool showLabelAboveField;
  final String? Function(String?)? validator;
  final InputDecoration? inputDecoration;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppDropdownField({
    super.key,
    required this.controller,
    required this.label,
    required this.items,
    required this.itemLabel,
    required this.onItemSelected,
    this.selectedItem,
    this.hintText,
    this.showLabelAboveField = true,
    this.inputDecoration,
    this.readOnly = true,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return showLabelAboveField
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 14.spMin, fontWeight: FontWeight.w500),
              ),
              6.h.verticalSpace,
              field(context),
            ],
          )
        : field(context);
  }

  Widget field(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: () => _showBottomSheet(context),
      validator: validator,
      decoration: inputDecoration ??
          InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 5.h,
              horizontal: 10.w,
            ),
            labelText: hintText,
            hintText: hintText,
            suffixIconConstraints: BoxConstraints(minHeight: 30,minWidth: 30),
            suffixIcon: suffixIcon ?? const Icon(Icons.arrow_drop_down),
            prefixIcon: prefixIcon,
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      showDragHandle: true,
      enableDrag: true,
      elevation: 10,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),

      ),
      builder: (context) {
        return SizedBox(
          height: .85.sh,
          child: _BottomSheetContent<T>(
            items: items,
            itemLabel: itemLabel,
            onItemSelected: (item) {
              controller.text = itemLabel(item);
              onItemSelected(item);
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }
}

class _BottomSheetContent<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemLabel;
  final void Function(T) onItemSelected;

  const _BottomSheetContent({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.onItemSelected,
  });

  @override
  State<_BottomSheetContent<T>> createState() => _BottomSheetContentState<T>();
}

class _BottomSheetContentState<T> extends State<_BottomSheetContent<T>> {
  late List<T> filteredItems;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredItems = widget.items;
    searchController.addListener(_filterItems);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterItems);
    searchController.dispose();
    super.dispose();
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems = widget.items
          .where((item) => widget.itemLabel(item).toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return ListTile(
                  title: Text(widget.itemLabel(item)),
                  onTap: () => widget.onItemSelected(item),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
