import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/concierge/login/concierge_more_page.dart';
import 'package:homework/values/extensions/context_ext.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ExploreLinksWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12).r,
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "read, discover, explore..",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 24.spMin, fontWeight: FontWeight.w500),
          ),
          24.verticalSpace,
          Divider(
            color: Theme.of(context).colors.primaryColor,
            thickness: 1,
          ),
          SizedBox(height: 8),
          _buildLink(
              context: context,
              title: "about us",
              url: "https://example.com/about-us"),
          _buildLink(
              context: context,
              title: "terms of service",
              url: "https://example.com/terms-of-service"),
          _buildLink(
              context: context,
              title: "privacy policy",
              url: "https://example.com/privacy-policy"),
          _buildLink(
              context: context, title: "faq", url: "https://example.com/faq"),
          _buildLink(
            context: context,
            title: "become a workspace host",
            url: "https://example.com/workspace-host",
            onTap: () {
              showAppBottomSheet(
                context,
                ConciergeMorePage(),
              );
            },
          ),
          _buildLink(
              context: context,
              title: "become a property host",
              url: "https://example.com/property-host",
              onTap: () {
                showAppBottomSheet(
                  context,
                  ConciergeMorePage(),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildLink(
      {required BuildContext context,
      required String title,
      required String url,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: () {},

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 14.spMin, fontWeight: FontWeight.w500),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
