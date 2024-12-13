import 'package:homework/values/extensions/theme_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationControl extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageChanged;

  const PaginationControl({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
  });

  List<Widget> _buildPageNumbers(BuildContext context) {
    List<Widget> pageWidgets = [];

    // Determine which pages to show based on the current page
    if (totalPages <= 3) {
      // Show all pages if total pages are 3 or fewer
      for (int i = 1; i <= totalPages; i++) {
        pageWidgets.add(_buildPageButton(i, context));
      }
    } else {
      // Show previous pages based on current position
      if (currentPage > 2) {
        pageWidgets.add(_buildPageButton(1, context)); // Always show first page
        pageWidgets.add(_buildEllipsis(
            context)); // Show ellipsis if hidden pages before current page
      }

      // Show the middle range (up to 3 pages)
      int startPage = currentPage > 1 ? currentPage : currentPage;
      int endPage = currentPage < totalPages ? currentPage : currentPage;
      for (int i = startPage; i <= endPage; i++) {
        pageWidgets.add(_buildPageButton(i, context));
      }

      // Show next pages based on current position
      if (currentPage < totalPages - 1) {
        pageWidgets.add(_buildEllipsis(
            context)); // Show ellipsis if hidden pages after current page
        pageWidgets.add(
            _buildPageButton(totalPages, context)); // Always show last page
      }
    }

    return pageWidgets;
  }

  Widget _buildPageButton(int page, BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        onPageChanged(page);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: currentPage == page
                ? theme.colors.strokeColor
                : Colors.transparent,
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: theme.textTheme.titleMedium?.copyWith(
              fontSize: 16.spMin,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEllipsis(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text(
        '...',
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 16.spMin,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (totalPages == 0) return const SizedBox.shrink(); // Hide if no pages
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: currentPage > 1
                ? () {
                    onPageChanged(currentPage - 1);
                  }
                : null,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: currentPage > 1
                      ? theme.primaryColor
                      : theme.primaryColor.withOpacity(.4),
                ),
                6.w.horizontalSpace,
                Text(
                  "previous",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: currentPage > 1
                        ? theme.primaryColor
                        : theme.primaryColor.withOpacity(.4),
                  ),
                ),
              ],
            ),
          ),
          /*Spacer(),*/
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: _buildPageNumbers(context),
            ),
          ),
          /*Spacer(),*/

          // Next button
          GestureDetector(
            onTap: currentPage < totalPages
                ? () {
                    onPageChanged(currentPage + 1);
                  }
                : null,
            child: Row(
              children: [
                Text(
                  "next",
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: currentPage < totalPages
                        ? theme.primaryColor
                        : theme.primaryColor.withOpacity(.4),
                  ),
                ),
                6.w.horizontalSpace,
                Icon(
                  Icons.arrow_forward_ios,
                  color: currentPage < totalPages
                      ? theme.primaryColor
                      : theme.primaryColor.withOpacity(.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
