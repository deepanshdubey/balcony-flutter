import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/chat/chat_widget.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: List.generate(
        8,
        (index) => const ChatWidget(
          image: Assets.dummyChatUser,
          name: "Pranav Ray",
          lastMessage: "okay sure!!",
          time: "12:25 PM",
        ),
      ),
    );
  }
}

void showChatBottomSheet(BuildContext context) {
  showAppBottomSheet(context, const ChatPage());
}

void showAppBottomSheet(BuildContext context, Widget any) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: context.height * .8,
      padding: const EdgeInsets.only(top: 100),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: any,
    ),
  );
}
