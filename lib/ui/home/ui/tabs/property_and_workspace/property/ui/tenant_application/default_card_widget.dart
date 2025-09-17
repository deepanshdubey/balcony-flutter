import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/ui/home/ui/tabs/more/ui/wallet/ui/wallet_page.dart';
import 'package:homework/values/colors.dart';
import 'package:homework/values/extensions/context_ext.dart';

class DefaultCardWidget extends StatelessWidget {
  final CardData? card;
  final VoidCallback? onDefaultCardChanged;

  const DefaultCardWidget({
    super.key,
    this.card,
    this.onDefaultCardChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "card",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(),
        ),
        8.h.verticalSpace,
        Row(
          children: [
            Icon(
              Icons.credit_card,
              color: appColor.primaryColor,
            ),
            8.w.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(card?.brand ?? "no default card"),
                  Text(
                    "there is a 2.9% + 30\€ processing fee",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 8.spMin),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(" **** **** **** ${card?.cardNumber ?? "****"}"),
                GestureDetector(
                  onTap: () {
                    showAppBottomSheet(context, WalletPage(
                      onDefaultCardUpdated: onDefaultCardChanged
                    ));
                  },
                  child: Text(
                    "update",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: 12.spMin,
                        ),
                  ),
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
