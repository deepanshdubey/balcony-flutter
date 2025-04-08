import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/ui/concierge/model/concierge_tanant_response.dart';

class TenantRow extends StatefulWidget {
  final ConciergeTenant? conciergeTenant;
  final VoidCallback onInfo;

  const TenantRow({
    Key? key,
    required this.onInfo,
    required this.conciergeTenant,
  }) : super(key: key);

  @override
  State<TenantRow> createState() => _TenantRowState();
}

class _TenantRowState extends State<TenantRow> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Checkbox(
          value: false,
          onChanged: (value) {},
        ),
        Expanded(
          flex: 3,
          child: Text(
            "${widget.conciergeTenant?.info?.firstName} ${widget.conciergeTenant?.info?.lastName}",
            style: theme.textTheme.bodyLarge,
          ),
        ),
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: widget.onInfo,
            child: Text(
              "•••",
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: 8.spMin,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        20.horizontalSpace
      ],
    );
  }
}
