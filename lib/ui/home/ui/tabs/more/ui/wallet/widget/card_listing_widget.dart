import 'package:balcony/data/model/response/card_data.dart';
import 'package:balcony/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardListingWidget extends StatelessWidget {
  final List<CardData> cards;
  final Function(CardData) onEditClicked;
  final Function(CardData) onDeleteClicked;

  const CardListingWidget(
      {super.key,
      required this.cards,
      required this.onEditClicked,
      required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards
          .map(
            (e) => cardItem(context, e),
          )
          .toList(),
    );
  }

  Widget cardItem(BuildContext context, CardData e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.h.verticalSpace,
        Text(
          "name: ${e.name}",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
                  border: Border.all(color: Colors.black.withOpacity(.25))),
              child: Text(
                "**** **** **** ${e.cardNumber ?? ""}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(),
              ),
            ),
            16.w.horizontalSpace,
            GestureDetector(
                onTap: () {
                  onEditClicked(e);
                },
                child: Text(
                  "edit",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                )),
            Container(
              width: 1.h,
              height: 16.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              color: appColor.primaryColor,
            ),
            GestureDetector(
                onTap: () {
                  onDeleteClicked(e);
                },
                child: Text(
                  "delete",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(decoration: TextDecoration.underline),
                )),
          ],
        ),
      ],
    );
  }
}
