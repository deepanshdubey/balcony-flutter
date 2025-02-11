import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/concierge/model/ongoing_response.dart';
import 'package:homework/widget/primary_button.dart';
import 'package:intl/intl.dart';

@RoutePage()
class OutgoingParcelDetailsPage extends StatefulWidget {
  final Parcel? parcel;

  const OutgoingParcelDetailsPage({Key? key, required this.parcel})
      : super(key: key);

  @override
  State<OutgoingParcelDetailsPage> createState() =>
      _OutgoingParcelDetailsPageState();
}

class _OutgoingParcelDetailsPageState
    extends State<OutgoingParcelDetailsPage> {






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



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24 , right: 24 , top: 60 ).r,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.r)),
            color: Colors.grey[200],
            border: Border.all(color: Colors.black.withOpacity(.25)),
          ),
          padding: const EdgeInsets.all(24).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.verticalSpace,
              Text(
                "Tenant Details",
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
                "Tenant's name",
                "${widget.parcel?.tenant?.info?.firstName} ${widget.parcel?.tenant?.info?.lastName}",
              ),
              _buildKeyValueRow(
                context,
                "Property",
                widget.parcel?.tenant?.selectedUnit?.property?.name ?? "N/A",
              ),
            /*  _buildKeyValueButtonRow(
                context,
                "awaiting pickup",
                onIncrease:() => conciergeStore.parcelAdd( "concierge-tenant" , widget.conciergeTenant?.Id ?? ""),
                onDecrease: () => conciergeStore.parcelDelete( "concierge-tenant" , widget.conciergeTenant?.Id ?? ""),
              ),*/
              _buildKeyValueRow(
                context,
                "units",
                widget.parcel?.tenant?.selectedUnit?.unit.toString() ?? "N/A",
              ),
              _buildKeyValueRow(
                context,
                "Drop-off Day & time",
                formatDate(widget.parcel?.updatedAt ?? "") ,
              ),
              _buildKeyValueRow(
                context,
                "Additional notes",
                widget.parcel?.note ?? "N/A",
              ),
              24.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PrimaryButton(
                    text: "Close",
                    onPressed: () {
                      context.router.maybePop();
                    },
                  ),
                  10.horizontalSpace,
               /*   PrimaryButton(
                    text: "Delete",
                    onPressed: () {
                    //  conciergeStore.tenantDelete(widget.conciergeTenant?.Id ?? "");
                    },
                  )*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    return DateFormat('dd/MM/yyyy | hh:mm a').format(dateTime);
  }

}
