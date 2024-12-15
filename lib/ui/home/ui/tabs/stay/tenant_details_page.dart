import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/data/model/response/tenant_details.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/store/wallet_store.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TenantDetailsPage extends StatefulWidget {
  final Tenants? tenants;

  const TenantDetailsPage({super.key, this.tenants});

  @override
  State<TenantDetailsPage> createState() => _TenantDetailsPageState();
}

class _TenantDetailsPageState extends State<TenantDetailsPage> {
  final TextEditingController routingController = TextEditingController();
  final TextEditingController accountController = TextEditingController();
  CardData? selectedCard;
  final ValueNotifier<String> selectedOption = ValueNotifier<String>("Card");

  @override
  void initState() {
    walletStore.getCards();
    super.initState();
  }

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
              const AppBackButton(
                text: "Back",
              ),
              20.verticalSpace,
              _buildPropertyDetailsSection(context),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyDetailsSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8).r,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
              widget.tenants?.selectedUnit?.property?.info?.name ?? ""),
          Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "leasing details",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.spMin,
                      ),
                ),
                20.verticalSpace,
                _buildLeasingDetails(),
                20.verticalSpace,
                Divider(color: Colors.grey.shade400),
                20.verticalSpace,
                _buildLeaseDates(),
                20.verticalSpace,
                Divider(color: Colors.grey.shade400),
                20.verticalSpace,
                Text(
                  "User info",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.spMin,
                      ),
                ),
                20.verticalSpace,
                _buildUserInfo(),
                20.verticalSpace,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      height: 60.h,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
      decoration: BoxDecoration(
        color: const Color(0xFFCCDDDC),
        borderRadius: BorderRadius.vertical(top: const Radius.circular(8).r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 17.spMin,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeasingDetails() {
    final rentAmount = widget.tenants?.agreement?.rent ?? 0.0;
    final securityFee = widget.tenants?.agreement?.securityDepositFee ?? 0.0;
    final totalAmount = rentAmount + securityFee;
    return // Calculate total dynamically

        Column(
      children: [
        _buildKeyValueRow("Rent Amount", "\$${rentAmount.toStringAsFixed(2)}"),
        20.verticalSpace,
        _buildKeyValueRow(
            "Security fee", "\$${securityFee.toStringAsFixed(2)}"),
        20.verticalSpace,
        _buildKeyValueRow("Total", "\$${totalAmount.toStringAsFixed(2)}",
            isBold: true),
      ],
    );
    ;
  }

  Widget _buildLeaseDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Lease Start Date",
            formatDate(widget.tenants?.agreement?.leaseStartDate)),
        20.verticalSpace,
        _buildKeyValueRow("Lease End Date",
            formatDate(widget.tenants?.agreement?.leaseEndDate)),
      ],
    );
  }

  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildKeyValueRow("Name", session.user.firstName ?? ""),
        20.verticalSpace,
        _buildKeyValueRow("Email", session.user.email ?? ""),
        20.verticalSpace,
        _buildKeyValueRow("Phone", session.user.phone ?? ""),
      ],
    );
  }

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      return DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
    } catch (e) {
      print("Error parsing date: $e");
      return "";
    }
  }

  Widget _buildKeyValueRow(String key, String value, {bool isBold = false}) {
    return Row(
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
    );
  }
}
