import 'package:flutter/material.dart';
import 'package:homework/widget/primary_button.dart';

/// A bottom-sheet widget to select multiple properties from a given map of id→name.
class SelectPropertyWidget extends StatefulWidget {
  /// Map of property IDs to their display names.
  final Map<String, String?> propertyMap;

  /// Callback invoked with the list of selected property IDs when confirmed.
  final ValueChanged<List<String>> onPropertiesSelected;

  const SelectPropertyWidget({
    super.key,
    required this.propertyMap,
    required this.onPropertiesSelected,
  });

  /// Show the selection widget as a modal bottom sheet.
  static Future<void> showAsBottomSheet({
    required BuildContext context,
    required Map<String, String?> propertyMap,
    required ValueChanged<List<String>> onPropertiesSelected,
  }) async {
    await showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SelectPropertyWidget(
        propertyMap: propertyMap,
        onPropertiesSelected: onPropertiesSelected,
      ),
    );
  }

  @override
  _SelectPropertyWidgetState createState() => _SelectPropertyWidgetState();
}

class _SelectPropertyWidgetState extends State<SelectPropertyWidget> {
  /// Set of currently selected property IDs.
  final Set<String> _selectedIds = {};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Properties',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // List of checkboxes
          ...widget.propertyMap.entries.map((entry) {
            final id = entry.key;
            final name = entry.value ?? '';
            final isSelected = _selectedIds.contains(id);
            return CheckboxListTile(
              value: isSelected,
              title: Text(name, style: theme.textTheme.bodyLarge),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    _selectedIds.add(id);
                  } else {
                    _selectedIds.remove(id);
                  }
                });
              },
            );
          }).toList(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: 'Confirm',
              enabled: _selectedIds.isNotEmpty,
              onPressed: () {
                Navigator.pop(context);
                widget.onPropertiesSelected(_selectedIds.toList());
              },
            ),
          ),
        ],
      ),
    );
  }
}
