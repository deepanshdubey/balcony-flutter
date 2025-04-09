import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/values/extensions/theme_ext.dart';

/// A tab widget that displays two property names at a time and allows navigation.
///
/// Takes the full list of [propertyNames] from outside and manages its own index state.
/// Optionally notifies [onIndexChanged] whenever the visible index changes.
class PropertyTab extends StatefulWidget {
  /// The list of property names to display (should contain at least one entry).
  final List<String?> propertyNames;

  const PropertyTab({
    super.key,
    required this.propertyNames,
  });

  @override
  _PropertyTabState createState() => _PropertyTabState();
}

class _PropertyTabState extends State<PropertyTab> {
  int _currentIndex = 0;

  void _incrementIndex() {
    if (_currentIndex < widget.propertyNames.length - 2) {
      setState(() => _currentIndex++);
    }
  }

  void _decrementIndex() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    final names = widget.propertyNames;
    final theme = Theme.of(context);

    if (names.isEmpty) {
      return Center(
        child: Text(
          'no properties available',
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 14.spMin,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    final first = names[_currentIndex] ?? '';
    final second =
        (_currentIndex + 1 < names.length) ? names[_currentIndex + 1] : null;

    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12).r,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentIndex > 0 ? _decrementIndex : null,
            icon: const Icon(Icons.arrow_back),
            color: _currentIndex > 0 ? theme.colors.primaryColor : Colors.grey,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),

          // First property
          Text(
            first,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 14.spMin,
              fontWeight: FontWeight.w500,
            ),
          ),

          if (second != null) ...[
            10.horizontalSpace,
            Container(height: 15.h, width: 1.5.w, color: Colors.black),
            10.horizontalSpace,
            Text(
              second,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],

          IconButton(
            onPressed:
                (_currentIndex < names.length - 2) ? _incrementIndex : null,
            icon: const Icon(Icons.arrow_forward),
            color: (_currentIndex < names.length - 2)
                ? theme.colors.primaryColor
                : Colors.grey,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
