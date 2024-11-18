import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:balcony/data/model/response/workspace_data.dart';
import 'package:balcony/router/app_router.dart';
import 'package:balcony/ui/home/ui/tabs/property_and_workspace/workspace/ui/wallets/wallet_page.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/values/extensions/theme_ext.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:balcony/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class WorkspacePaymentPage extends StatefulWidget {
  final WorkspaceData? workspaceData ;
  final String? selectedData ;
  WorkspacePaymentPage({super.key, this.workspaceData,  this.selectedData});

  @override
  State<WorkspacePaymentPage> createState() => _WorkspacePaymentPageState();
}

class _WorkspacePaymentPageState extends State<WorkspacePaymentPage> {
   TextEditingController promoController = TextEditingController();

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
                _buildSectionTitle(widget.workspaceData?.info?.name ?? "" , widget.workspaceData?.ratings?.toDouble()  ),
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

  Widget _buildSectionTitle(String title , double? rating) {
    final theme = Theme.of(context);
    return Container(
      width: 1.sw,
      height: 98.h,
      decoration: BoxDecoration(
          color: const Color(0xffCCDDDC),
          borderRadius: BorderRadius.only(
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
          _buildKeyValueRow('9 Bushwick Lofts x 2 days', "\$${widget.workspaceData?.pricing?.totalPerDay.toString()}" ),
          30.verticalSpace,
          Divider(),
          20.verticalSpace,
          _buildKeyValueRow('Subtotal', "\$${widget.workspaceData?.pricing?.totalPerDay.toString()}"),
          12.verticalSpace,
          _buildKeyValueRow('Service Fee', "\$${widget.workspaceData?.pricing?.maintenance?.fee.toString()}"),
          12.verticalSpace,
          _buildKeyValueRow('Total', "\$250.00"),
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
          _buildKeyValueRow('Service Hours', "8 AM - 5 PM EST"),
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
            textInputAction: TextInputAction.next, controller: promoController,
          ),
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
          Text('Payment Information',style: Theme.of(context)
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
                    return FractionallySizedBox(
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
                Text('add' ,style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
      child: PrimaryButton(text: "Book Workspace", onPressed:() {
      }, ),
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
                  color: Color(0xff71717A))),
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
}
