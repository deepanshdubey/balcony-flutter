import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopSnackBar extends StatefulWidget {
  final String message;
  final Color color;
  final Duration duration;
  final ThemeData theme;

  const TopSnackBar({
    super.key,
    required this.message,
    required this.color,
    required this.theme,
    this.duration = const Duration(seconds: 3),
  });

  @override
  _TopSnackBarState createState() => _TopSnackBarState();
}

class _TopSnackBarState extends State<TopSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse().then((_) => Navigator.of(context).pop());
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r))),
            child: SafeArea(
              child: Text(
                widget.message,
                maxLines: 4,
                style: widget.theme.textTheme.titleLarge
                    ?.copyWith(color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
