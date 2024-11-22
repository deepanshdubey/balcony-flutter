import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:balcony/core/alert/alert_manager.dart';
import 'package:balcony/data/model/response/promo_model.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/ui/home/store/promo_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/store/workspace_store.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/wallets/wallet_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

@RoutePage()
class WorkspacePaymentPage extends StatefulWidget {
  final WorkspaceData? workspaceData;

  final String? selectedData;

  final num? selectedDays;

  WorkspacePaymentPage(
      {super.key, this.workspaceData, this.selectedData, this.selectedDays});

  @override
  State<WorkspacePaymentPage> createState() => _WorkspacePaymentPageState();
}

class _WorkspacePaymentPageState extends State<WorkspacePaymentPage> {
  TextEditingController promoController = TextEditingController();
  List<ReactionDisposer>? disposers;
  ValueNotifier<String?> fieldError = ValueNotifier(null);
  ValueNotifier<int> promoDiscount = ValueNotifier(0) ;
  final promoStore = PromoStore();

  @override
  void initState() {
    addDisposer();
    super.initState();
  }

  @override
  void dispose() {
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => promoStore.errorMessage, (String? errorMessage) {
        if (errorMessage != null) {
          fieldError.value = errorMessage;

        }
      }),     reaction((_) => promoStore.promoResponse, (PromoModel? promoDetails) {
        if (promoDetails?.success ?? false) {
          alertManager.showSuccess(context, "Promo applied");
         promoDiscount.value = promoDetails?.promo?.discount ?? 0 ;
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(widget.workspaceData?.info?.name ?? "",
                    widget.workspaceData?.ratings?.toDouble()),
                const SizedBox(height: 8),
                _buildOrderDetails(),
                _buildTimeFrameSection(),
                _buildUserInfoSection(),
                _buildPromoCodeSection(),
                _buildPaymentSection(),
                _buildBookButton(context),
                32.verticalSpace
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double? rating) {
    final theme = Theme.of(context);
    return Container(
      width: 1.sw,
      height: 98.h,
      decoration: BoxDecoration(
          color: const Color(0xffCCDDDC),
          borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))
              .r),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700, fontSize: 17.spMin),
            ),
            8.verticalSpace,
            Row(
              children: [
                buildRatingStars(theme, rating ?? 0),
                6.horizontalSpace,
                Text(
                  "(${rating.toString()})",
                  maxLines: 1,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 11.spMax,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Details',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.spMin),
          ),
          12.verticalSpace,
          _buildKeyValueRow('9 Bushwick Lofts x ${widget.selectedDays} days',
              "\$${(widget.workspaceData?.pricing?.totalPerDay ?? 0) * (widget.selectedDays ?? 0)}"),
          30.verticalSpace,
          Divider(),
          20.verticalSpace,
          _buildKeyValueRow('Subtotal',
              "\$${(widget.workspaceData?.pricing?.totalPerDay ?? 0) * (widget.selectedDays ?? 0)}"),
          12.verticalSpace,
          _buildKeyValueRow(
              'Service Fee', "\$${workspaceStore.totalFee}"),
          12.verticalSpace,
          ValueListenableBuilder(valueListenable: promoDiscount, builder: (context, value, child) {
            return _buildKeyValueRow('Total',
                "\$${(widget.workspaceData?.pricing?.totalPerDay ?? 0) * (widget.selectedDays ?? 0) + (workspaceStore.totalFee) - value} ");
          },),
          16.verticalSpace,
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildTimeFrameSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Text(
            'Time Frame of Service',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.spMin),
          ),
          12.verticalSpace,
          buildTodayServiceHours(),
          12.verticalSpace,
          _buildKeyValueRow('Service Days', widget.selectedData ?? ""),
        ],
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          const Divider(),
          16.verticalSpace,
          Text('Your Info',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.spMin)),
          16.verticalSpace,
          const SizedBox(height: 4),
          _buildKeyValueRow('Name', "name"),
          12.verticalSpace,
          _buildKeyValueRow('Email', "email"),
          12.verticalSpace,
          _buildKeyValueRow('Phone', "phone"),
        ],
      ),
    );
  }

  Widget _buildPromoCodeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          const Divider(),
          16.verticalSpace,
          AppTextField(
            label: 'Promo code',
            hintText: "Promo code",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: promoController,
            suffixIcon: GestureDetector(
              onTap: () {
                promoStore.getPromo(code: promoController.text);
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0).r,
                child: Text("Apply"),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: fieldError,
            builder: (context, value, child) {
              return value != null
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        value!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    )
                  : const SizedBox();
            },
          )
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          const Divider(),
          16.verticalSpace,
          Text('Payment Information',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600, fontSize: 13.spMin)),
          12.verticalSpace,
          GestureDetector(
            onTap: () {
              context.maybePop();
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                builder: (BuildContext context) {
                  return const FractionallySizedBox(
                    heightFactor: 0.8,
                    child: WalletPage(),
                  );
                },
              );
            },
            child: Row(
              children: [
                Text("No card yet!"),
                Spacer(),
                Text('add',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14.spMin,
                        color: appColor.primaryColor,
                        decoration: TextDecoration.underline)),
              ],
            ),
          ),
          16.verticalSpace
        ],
      ),
    );
  }

  Widget _buildBookButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: PrimaryButton(
        text: "Book Workspace",
        onPressed: () {},
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 13.spMin,
                  color: const Color(0xff71717A))),
          Text(value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.normal, fontSize: 13.spMin)),
        ],
      ),
    );
  }

  Widget buildRatingStars(ThemeData theme, double rating) {
    int fullStars = rating.floor(); // Full stars to show
    bool hasHalfStar =
        (rating - fullStars) >= 0.5; // Whether to show a half star

    return Row(
      children: List.generate(5, (index) {
        if (index < fullStars) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: .5.w),
            child: AppImage(
              assetPath: theme.assets.ratingStar,
              height: 12.r,
              width: 12.r,
            ),
          );
        } else if (index == fullStars && hasHalfStar) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: .5.w),
              child: Icon(
                Icons.star,
                color: theme.primaryColor,
                size: 12.r,
              ));
        } else {
          return Icon(
            Icons.star_border,
            color: theme.primaryColor,
            size: 12.r,
          );
        }
      }),
    );
  }

  Widget buildTodayServiceHours() {
    final today = DateTime.now().weekday;

    final todaysTimes =
        getServiceHoursForToday(widget.workspaceData?.times ?? Times(), today);

    return _buildKeyValueRow('Service Hours', todaysTimes);
  }

  String getServiceHoursForToday(Times times, int day) {
    switch (day) {
      case DateTime.monday:
        return '${times.monday?.startTime} - ${times.monday?.endTime}';
      case DateTime.tuesday:
        return '${times.tuesday?.startTime} - ${times.tuesday?.endTime}';
      case DateTime.wednesday:
        return '${times.wednesday?.startTime} - ${times.wednesday?.endTime}';
      case DateTime.thursday:
        return '${times.thursday?.startTime} - ${times.thursday?.endTime}';
      case DateTime.friday:
        return '${times.friday?.startTime} - ${times.friday?.endTime}';
      case DateTime.saturday:
        return '${times.saturday?.startTime} - ${times.saturday?.endTime}';
      case DateTime.sunday:
        return '${times.sunday?.startTime} - ${times.sunday?.endTime}';
      default:
        return 'Closed'; // Fallback for any unexpected cases
    }
  }
}