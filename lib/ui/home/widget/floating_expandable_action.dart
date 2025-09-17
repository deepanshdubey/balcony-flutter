import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingExpandableActions extends StatefulWidget {
  final void Function()? onChat;
  final void Function()? onEmail;
  final void Function()? onSchedule;
  final void Function()? onCall;

  const FloatingExpandableActions({
    super.key,
    this.onChat,
    this.onEmail,
    this.onSchedule,
    this.onCall,
  });

  @override
  State<FloatingExpandableActions> createState() =>
      _FloatingExpandableActionsState();
}

class _FloatingExpandableActionsState extends State<FloatingExpandableActions>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  void _toggle() {
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  Widget _actionButton(
      {required IconData icon,
      required String label,
      required VoidCallback? onTap}) {
    return FadeTransition(
      opacity: _fade,
      child: GestureDetector(
        onTap: () {
          _toggle();
          onTap?.call();
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: label == "chat" ? const Color(0xff005451) : Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: label == "chat" ? Colors.white : const Color(0xff005451),
                size: 22.r,
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  color:
                      label == "chat" ? Colors.white : const Color(0xff005451),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: label == "chat" ? Colors.white : const Color(0xff005451),
                size: 18.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Actions
        Positioned(
          bottom: 80.h,
          right: 24.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (_expanded)
                _actionButton(
                    icon: Icons.chat_bubble_outline,
                    label: "chat",
                    onTap: widget.onChat),
              if (_expanded)
                _actionButton(
                    icon: Icons.email_outlined,
                    label: "email",
                    onTap: widget.onEmail),
              if (_expanded)
                _actionButton(
                    icon: Icons.calendar_today_outlined,
                    label: "schedule",
                    onTap: widget.onSchedule),
              if (_expanded)
                _actionButton(
                    icon: Icons.phone_outlined,
                    label: "call | text",
                    onTap: widget.onCall),
            ],
          ),
        ),
        // Main FAB
        Positioned(
          bottom: 24.h,
          right: 24.w,
          child: FloatingActionButton(
            backgroundColor: const Color(0xff005451),
            onPressed: _toggle,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _expanded
                  ? const Icon(Icons.close,
                      key: ValueKey('close'), color: Colors.white)
                  : const Icon(Icons.add,
                      key: ValueKey('add'), color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
