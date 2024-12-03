import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/dashboard/store/dashboard_store.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePayoutWidget extends StatefulWidget {
  final bool isWorkspace;

  const UpdatePayoutWidget({
    super.key,
    this.isWorkspace = true,
  });

  @override
  State<UpdatePayoutWidget> createState() => _UpdatePayoutWidgetState();
}

class _UpdatePayoutWidgetState extends State<UpdatePayoutWidget> {
  List<ReactionDisposer>? disposers;
  var store = DashboardStore();

  @override
  void initState() {
    super.initState();
    store.autoStatus();
    addDisposer();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => store.updatePayoutInfoResponse, (response) {
        if (response != null) {
          openUrl(response);
        }
      }),
      reaction((_) => store.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          alertManager.showError(context, errorMessage);
        }
      }),
    ];
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        border: Border.all(color: Colors.black.withOpacity(.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'update payout',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.spMin,
                ),
          ),
          16.h.verticalSpace,
          Text(
            "please click the link below as it would prompt you to a different link which is with our payment partner Stripe. You are able to update your payout info there.",
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w300,
              color: theme.primaryColor,
            ),
          ),
          16.h.verticalSpace,
          Observer(builder: (context) {
            var isLoading = store.isLoading;
            return PrimaryButton(
              text: "update payout info",
              isLoading: isLoading,
              onPressed: () {
                store.updatePayoutInfo(isWorkspace: widget.isWorkspace);
              },
              icon: const Icon(
                Icons.open_in_new,
                color: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }
}

Future<void> openUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}
