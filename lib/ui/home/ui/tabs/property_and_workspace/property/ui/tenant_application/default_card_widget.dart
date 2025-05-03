import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/values/colors.dart';

class DefaultCardWidget extends StatelessWidget {
  final String? type, cardNumber;

  const DefaultCardWidget({super.key, this.type, this.cardNumber});

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
                  Text(type ?? "no default card"),
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
              children: [
                Text(cardNumber ?? ""),
                GestureDetector(
                  onTap: () {},
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
