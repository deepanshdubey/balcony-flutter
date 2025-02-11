import 'package:homework/data/model/response/support_ticket_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'ticket_row.dart';

class TicketListWidget extends StatelessWidget {
  final List<SupportTicketData> tickets;
  final bool isLoading;
  final Function(SupportTicketData) onViewReply;

  TicketListWidget({
    Key? key,
    required this.tickets,
    required this.isLoading,
    required this.onViewReply,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          border: Border.all(color: Colors.black.withOpacity(.25))),
      child: Column(
        children: [
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20).r,
              child: Row(
                children: [
                /*  Expanded(
                      flex: 1,
                      child: Checkbox(
                        value: false,
                        onChanged: (value) {},
                      )),*/
                  Expanded(
                    flex: 4,
                    child: Text(
                      'ticket #',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  8.w.horizontalSpace,
                  Expanded(
                    flex: 3,
                    child: Text(
                      'view or reply',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          tickets.isNotEmpty
              ? ListView.separated(
                  itemCount: tickets.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var item = tickets[index];
                    return TicketRow(
                      ticket: item,
                      onViewReply: onViewReply,
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 1.h,
                    color: Colors.black26,
                  ),
                )
              : Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : const Text('no results.'),
                  ),
                ),
        ],
      ),
    );
  }
}
