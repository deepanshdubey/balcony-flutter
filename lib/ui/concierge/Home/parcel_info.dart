import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/generated/assets.dart';
import 'package:homework/ui/concierge/store/concierge_store.dart';
import 'package:homework/values/extensions/theme_ext.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:mobx/mobx.dart';

class ParcelInfo extends StatefulWidget {
  const ParcelInfo({super.key});

  @override
  State<ParcelInfo> createState() => _ParcelInfoState();
}

class _ParcelInfoState extends State<ParcelInfo> {
  final conciergeStore = ConciergeStore();
  List<ReactionDisposer>? disposers;



  @override
  void initState() {
    addDisposer();
    conciergeStore.conciergeParcelMe();
    super.initState();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => conciergeStore.conciergeParcelMeResponse, (response) {

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
    return Observer(
      builder: (context) {
        return conciergeStore.isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).primaryColor, // Adjust loader color
          ),
        )
            : Container(
          width: 235.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            border: Border.all(color: Colors.black.withOpacity(.25)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                22.verticalSpace,
                Row(
                  children: [
                    Image.asset(
                      Assets.imagesAlertCircle,
                      height: 22.r,
                      width: 22.r,
                    ),
                    5.horizontalSpace,
                    Text(
                      conciergeStore.conciergeParcelMeResponse?.parcels?[0].toString() ?? "0" ,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 43.spMin,
                        color: Theme.of(context).colors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                9.verticalSpace,
                Text(
                    "This is the total amount of tenants that has yet to pick-up their parcel. You may mass email tenants to remind them to pick-up."),
                20.verticalSpace,
                PrimaryButton(
                  text: "email",
                  onPressed: () {},
                ),
                20.verticalSpace
              ],
            ),
          ),
        );
      }
    );
  }
}
