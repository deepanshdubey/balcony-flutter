import 'package:homework/core/alert/alert_manager_impl.dart';
import 'package:homework/data/model/response/card_data.dart';
import 'package:homework/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/values/extensions/theme_ext.dart';

class CardListingWidget extends StatefulWidget {
  final List<CardData> cards;
  final Function(CardData) onEditClicked;
  final Function(CardData) onDeleteClicked;
  final Function(CardData) onCheckboxChanged;

  const CardListingWidget({
    super.key,
    required this.cards,
    required this.onEditClicked,
    required this.onDeleteClicked,
    required this.onCheckboxChanged,
  });

  @override
  State<CardListingWidget> createState() => _CardListingWidgetState();
}

class _CardListingWidgetState extends State<CardListingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.cards
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
            Checkbox(
              value: e.isDefault,
              onChanged: (value) {
                setState(() {
                  for (var card in widget.cards) {
                    card.isDefault = false;
                  }
                  e.isDefault = value ?? false;
                });
                widget.onCheckboxChanged(e);
              },
            ),
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
           /* Column(
              children: [
                GestureDetector(
                    onTap: () {
                      widget.onEditClicked(e);
                    },
                    child: Icon(Icons.edit,color: Theme.of(context).primaryColor)),
              ],
            ),
            Container(
              width: 1.h,
              height: 16.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              color: appColor.primaryColor,
            ),*/
            GestureDetector(
                onTap: () {
                  widget.onDeleteClicked(e);
                },
                child: Icon(Icons.delete ,color: Theme.of(context).colors.primaryColor),
            )
          ],
        ),
      ],
    );
  }
}