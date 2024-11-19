import 'package:auto_route/auto_route.dart';
import 'package:balcony/values/colors.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/bokking_dialog.dart';
import 'package:balcony/widget/button_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookingDatePages extends StatefulWidget {
  const BookingDatePages({super.key});

  @override
  State<BookingDatePages> createState() => _BookingDatePagesState();
}

class _BookingDatePagesState extends State<BookingDatePages> {
  final TextEditingController promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              AppBackButton(
                text: "back",
                onTap: () => context.router.maybePop(),
              ),
              20.verticalSpace,
              _buildOrderContainer(context),
              20.verticalSpace,
              _buildSupportSection(context),
              16.verticalSpace,
              _buildContactOptions(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderContainer(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: "Order Oe31b70H", date: "November 23, 2023"),
          20.verticalSpace,
          _buildOrderDetails(context),
          20.verticalSpace,
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 20).r,
             child: Divider(),
           ),
          20.verticalSpace,
          _buildUserInfoSection(context),
          _buildCancelOrderSection(context),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context) {
    return SectionContainer(
      title: "Order Details",
      children: [
        KeyValueRow(label: '9 Bushwick Lofts x 2 days'),
        20.verticalSpace,
        const Divider(),
        20.verticalSpace,
        KeyValueRow(label: 'Subtotal'),
        KeyValueRow(label: 'Service Fee'),
        KeyValueRow(label: 'Total', value: "\$250.00"),
      ],
    );
  }

  Widget _buildUserInfoSection(BuildContext context) {
    return SectionContainer(
      title: "User's info",
      children: [
        KeyValueRow(label: 'Name', value: "name"),
        KeyValueRow(label: 'Email', value: "email"),
        KeyValueRow(label: 'Phone', value: "phone"),
        20.verticalSpace
      ],
    );
  }

  Widget _buildCancelOrderSection(BuildContext context) {
    return SectionContainer(
      children: [
        const Divider(),
        20.verticalSpace,
        Text(
          'Cancel order',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13.spMin,
          ),
        ),
        6.verticalSpace,
        Text(
          'You can cancel before 24 hours of the book start date/time for a full refund. Failure to cancel before 24 hours results in a 25% late cancelation charge.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 8.spMin,
          ),
        ),
        20.verticalSpace,
        BorderButton(
          label: "cancel booking",
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CompleteDialog(
                  title: "Your all set!",
                  message:
                  "You should receive an email with the booking details. You can also visit the booking detail page as well.",
                  primaryButtonText: "Visit booking details page",
                  secondaryButtonText: "Done",
                  onPrimaryButtonPressed: () {
                    Navigator.of(context).pop();
                  },
                  onSecondaryButtonPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                );
              },
            );
          },
        ),
        20.verticalSpace
      ],
    );
  }

  Widget _buildSupportSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Host for Support",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14.spMin,
            color: appColor.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "Chat &/or call with the workspace host before booking",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14.spMin,
            color: appColor.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactOptions(BuildContext context) {
    return Row(
      children: [
        Text(
          "chat",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14.spMin,
            color: appColor.primaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
        16.horizontalSpace,
        Container(
          color: const Color(0xff005451),
          height: 20.h,
          width: 1.w,
        ),
        16.horizontalSpace,
        Text(
          "call",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 14.spMin,
            decoration: TextDecoration.underline,
            color: appColor.primaryColor,
          ),
        ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String date;

  const SectionTitle({
    required this.title,
    required this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 98.h,
      decoration: BoxDecoration(
        color: const Color(0xffCCDDDC),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ).r,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 17.spMin,
              ),
            ),
            8.verticalSpace,
            Text("Date: $date"),
          ],
        ),
      ),
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String? title;
  final List<Widget> children;

  const SectionContainer({
    this.title,
    required this.children,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13.spMin,
              ),
            ),
            12.verticalSpace,
          ],
          ...children,
        ],
      ),
    );
  }
}

class KeyValueRow extends StatelessWidget {
  final String label;
  final String value;

  const KeyValueRow({
    required this.label,
    this.value = "",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 13.spMin,
              color: const Color(0xff71717A),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 13.spMin,
            ),
          ),
        ],
      ),
    );
  }
}


