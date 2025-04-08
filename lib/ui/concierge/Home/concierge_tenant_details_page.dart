import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/alert/alert_manager.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class ConciergeTenantDetailsPage extends StatefulWidget {
  final ConciergeTenant? conciergeTenant;

  const ConciergeTenantDetailsPage({Key? key, required this.conciergeTenant})
      : super(key: key);

  @override
  State<ConciergeTenantDetailsPage> createState() =>
      _ConciergeTenantDetailsPageState();
}

class _ConciergeTenantDetailsPageState
    extends State<ConciergeTenantDetailsPage> {
  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;
  ValueNotifier<int?> parcelCount = ValueNotifier(null);

  @override
  void initState() {
    parcelCount.value = widget.conciergeTenant?.parcels;
    addDisposer();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.parcelAddResponse, (response) {
        if (response?.success ?? false) {
          parcelCount.value = (parcelCount.value ?? 0) + 1;
        }
      }),
      reaction((_) => conciergeStore.parcelDeleteResponse, (response) {
        if (response?.success ?? false) {
          parcelCount.value = (parcelCount.value ?? 0) - 1;
        }
      }),
      reaction((_) => conciergeStore.tenantDeleteResponse, (response) {
        if (response?.success ?? false) {
          context.router.maybePop();
        }
      }),
      reaction((_) => conciergeStore.errorMessage, (String? errorMessage) {
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

  Widget _buildKeyValueRow(BuildContext context, String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.spMin,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.spMin,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyValueButtonRow(BuildContext context, String key,
      {VoidCallback? onIncrease, VoidCallback? onDecrease}) {
    return ValueListenableBuilder(
        valueListenable: parcelCount,
        builder: (BuildContext context, int? value, Widget? child) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  key,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 13.spMin,
                      ),
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: onDecrease,
                        child: Image.asset(
                          Assets.imagesArrowLeftCircle,
                          height: 18.r,
                          width: 18.r,
                        )),
                    4.horizontalSpace,
                    Text(
                      parcelCount.value.toString(),
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.spMin,
                          ),
                    ),
                    4.horizontalSpace,
                    GestureDetector(
                        onTap: onIncrease,
                        child: Image.asset(
                          Assets.imagesArrowRightCircle,
                          height: 18.r,
                          width: 18.r,
                        )),
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 60).r,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            color: Colors.grey[200],
            border: Border.all(color: Colors.black.withAlpha(70)),
          ),
          padding: const EdgeInsets.all(24).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Text(
                "tenant details",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 23.spMin,
                  fontWeight: FontWeight.w500,
                  color: theme.primaryColor,
                ),
              ),
              16.verticalSpace,
              Divider(
                color: theme.primaryColor,
                thickness: 1,
              ),
              16.verticalSpace,
              _buildKeyValueRow(
                context,
                "tenant's name",
                "${widget.conciergeTenant?.info?.firstName} ${widget.conciergeTenant?.info?.lastName}",
              ),
              _buildKeyValueRow(
                context,
                "property",
                widget.conciergeTenant?.selectedUnit?.property?.name ?? "N/A",
              ),
              _buildKeyValueButtonRow(
                context,
                "awaiting pickup",
                onIncrease: () => conciergeStore.parcelAdd(
                    "concierge-tenant", widget.conciergeTenant?.Id ?? ""),
                onDecrease: () => conciergeStore.parcelDelete(
                    "concierge-tenant", widget.conciergeTenant?.Id ?? ""),
              ),
              _buildKeyValueRow(
                context,
                "phone",
                widget.conciergeTenant?.info?.phone ?? "N/A",
              ),
              _buildKeyValueRow(
                context,
                "email",
                widget.conciergeTenant?.info?.email ?? "N/A",
              ),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    text: "close",
                    onPressed: () {
                      context.router.maybePop();
                    },
                  ),
                  10.horizontalSpace,
                  PrimaryButton(
                    text: "delete",
                    onPressed: () {
                      conciergeStore
                          .tenantDelete(widget.conciergeTenant?.Id ?? "");
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
