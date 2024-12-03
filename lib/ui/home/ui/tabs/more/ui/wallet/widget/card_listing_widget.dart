import 'package:balcony/data/model/response/card_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardListingWidget extends StatelessWidget {
  final List<CardData> cards;
  final Function(CardData) onEditClicked;
  final Function(CardData) onDeleteClicked;

  const CardListingWidget(
      {super.key, required this.cards, required this.onEditClicked, required this.onDeleteClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: cards.map((e) => cardItem(context,e),).toList(),
    );
  }

  Widget cardItem(BuildContext context, CardData e) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Name: ${e.name}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 12.spMin,
              ),
            ),
            Text(
              e.cardNumber ?? "",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12.spMin,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: () {}, child: const Text("Edit")),
            TextButton(onPressed: () {}, child: const Text("Delete")),
          ],
        ),

      ],
    );
  }
}
