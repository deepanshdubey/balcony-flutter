import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/ui/concierge/Home/widget/select_properties_widget.dart';
import 'package:homework/ui/concierge/Home/widget/tenant_manager/header_text.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/app_outlined_button.dart';
import 'package:homework/widget/primary_button.dart';

import '../../../widget/app_text_field.dart' show AppTextField;

class BulkEmailWidget extends StatefulWidget {
  final int totalTenant;
  final bool isEmailSending;

  /// Map of property IDs to property names for selecting a specific property.
  final Map<String, String?> propertyMap;
  final Function(List<String>, String) onSendEmailTapped;

  const BulkEmailWidget({
    super.key,
    required this.totalTenant,
    required this.propertyMap,
    required this.onSendEmailTapped,
    this.isEmailSending = false,
  });

  @override
  _BulkEmailWidgetState createState() => _BulkEmailWidgetState();
}

class _BulkEmailWidgetState extends State<BulkEmailWidget> {
  final ValueNotifier<bool> _isAllSelected = ValueNotifier<bool>(true);
  final TextEditingController _messageController = TextEditingController();
  List<String> selectedProperties = [];

  @override
  void dispose() {
    _isAllSelected.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        padding: const EdgeInsets.all(24).r,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12).r,
          border: Border.all(color: Colors.black.withOpacity(.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderText(
              theme: theme,
              title: "Send Bulk Email\n(Announcements)".toLowerCase(),
              subtitle:
                  "Total tenants from all properties: ${widget.totalTenant}\nYou can email all tenants from all properties, or select a specific property."
                      .toLowerCase(),
            ),
            12.verticalSpace,
            _buildTabSelector(theme),
            12.verticalSpace,
            _buildSelectionUI(theme),
            12.verticalSpace,
            _buildMessageField(),
            16.verticalSpace,
            _buildSendButton(context, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildTabSelector(ThemeData theme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(theme, 'All Properties'.toLowerCase(), true),
          SizedBox(width: 12.w),
          _buildTab(theme, 'Specific Properties'.toLowerCase(), false),
        ],
      ),
    );
  }

  Widget _buildSelectionUI(ThemeData theme) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isAllSelected,
      builder: (context, isAll, _) {
        if (isAll) {
          // show all property names
          final allNames =
              widget.propertyMap.values.where((n) => n != null).join(", ");
          return Text(allNames, style: theme.textTheme.bodyMedium);
        }

        // specific-properties mode
        if (selectedProperties.isEmpty) {
          // prompt to select
          return AppOutlinedButton(
            text: "select properties",
            onPressed: () {
              SelectPropertyWidget.showAsBottomSheet(
                context: context,
                propertyMap: widget.propertyMap,
                onPropertiesSelected: (ids) {
                  setState(() => selectedProperties = ids);
                },
              );
            },
          );
        }

        // show chosen list + clear button
        final selectedNames = selectedProperties
            .map((id) => widget.propertyMap[id])
            .where((n) => n != null)
            .join(", ");

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Selected Properties", style: theme.textTheme.bodyLarge),
            4.verticalSpace,
            Text(selectedNames, style: theme.textTheme.bodyMedium),
            4.verticalSpace,
            PrimaryButton(
              text: "clear",
              onPressed: () => setState(() => selectedProperties.clear()),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTab(ThemeData theme, String text, bool isAllTab) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isAllSelected,
      builder: (context, isAll, _) {
        final isActive = isAllTab == isAll;
        return GestureDetector(
          onTap: () {
            if (isAllTab != isAll) {
              _isAllSelected.value = isAllTab;
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: isActive ? theme.colors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 13.spMin,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? theme.colors.backgroundColor
                    : theme.colors.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageField() {
    return AppTextField(
      controller: _messageController,
      label: '',
      showLabelAboveField: false,
      minLines: 4,
      maxLines: 4,
      hintText: 'Type your message/email here'.toLowerCase(),
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildSendButton(BuildContext context, ThemeData theme) {
    return SizedBox(
        width: 0.4.sw,
        child: PrimaryButton(
          text: "send email",
          isLoading: widget.isEmailSending,
          onPressed: () {
            var content = _messageController.text;
            if (content.isNotEmpty) {
              if (_isAllSelected.value) {
                _messageController.clear();
                widget.onSendEmailTapped(
                    _isAllSelected.value
                        ? widget.propertyMap.keys.toList()
                        : selectedProperties,
                    _messageController.text);
              } else if (selectedProperties.isNotEmpty) {
                _messageController.clear();
                widget.onSendEmailTapped(selectedProperties, _messageController.text);
              } else {
                alertManager.showError(context, "please select properties");
              }
            } else {
              alertManager.showError(context, "please enter email content");
            }
          },
        ));
  }
}
