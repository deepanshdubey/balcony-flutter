import 'package:balcony/generated/assets.dart';
import 'package:balcony/ui/home/ui/tabs/chat/chat_widget.dart';
import 'package:balcony/ui/home/ui/tabs/chat/store/chat_store.dart';
import 'package:balcony/values/extensions/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final chatStore = ChatStore();

  @override
  void initState() {
    chatStore.getAllConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      var chatData = chatStore.allConversationResponse?.conversations;
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        children: List.generate(
          chatStore.allConversationResponse?.conversations?.length ?? 0,
          (index) => ChatWidget(
            image: chatData?[index].member?.image ?? "",
            name: chatData?[index].member?.firstName ?? "",
            lastMessage: chatData?[index].lastMessage?.text ?? "",
            time: _formatTime(chatData?[index].lastMessage?.updatedAt),
            conversationId: chatData?[index].Id ?? "",
            receiverId: chatData?[index].member?.Id ?? "",
          ),
        ),
      );
    });
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
      padding: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: any,
    ),
  );
}

String _formatTime(String? timestamp) {
  if (timestamp == null) return '';
  final dateTime = DateTime.parse(timestamp);
  final formattedTime = DateFormat.jm().format(dateTime); // Example: "12:15 PM"
  return formattedTime;
}
