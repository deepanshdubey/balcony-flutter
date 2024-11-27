import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TicketRow extends StatefulWidget {
  final String ticketNumber;
  final VoidCallback onViewReply;

  const TicketRow({
    Key? key,
    required this.ticketNumber,
    required this.onViewReply,
  }) : super(key: key);

  @override
  _TicketRowState createState() => _TicketRowState();
}

class _TicketRowState extends State<TicketRow> {
  bool isChecked = false;

  ThemeData get theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
              },
            )),

        // Ticket Number
        Expanded(
          flex: 4,
          child: Text(widget.ticketNumber),
        ),
        8.w.horizontalSpace,
        // View or Reply Button
        Expanded(
          flex: 3,
          child: GestureDetector(
            onTap: widget.onViewReply,
            child: Text(
              'view or reply',
              style: theme.textTheme.titleMedium?.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
