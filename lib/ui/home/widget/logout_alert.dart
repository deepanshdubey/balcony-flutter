import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutAlertWidget extends StatelessWidget {
  final VoidCallback onLoginPressed;
  final VoidCallback onCancelPressed;

  const LogoutAlertWidget({
    required this.onLoginPressed,
    required this.onCancelPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "You have been logged out",
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: 16.spMin,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Please log in again to continue.",
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: 14.spMin,
        ),
      ),
      actions: [
        TextButton(
          onPressed: onCancelPressed,
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.grey, fontSize: 14.spMin),
          ),
        ),
        TextButton(
          onPressed: onLoginPressed,
          child: Text(
            "Login",
            style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14.spMin),
          ),
        ),
      ],
    );
  }
}
