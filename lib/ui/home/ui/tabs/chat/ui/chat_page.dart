import 'package:homework/ui/home/ui/tabs/chat/chat_widget.dart';
import 'package:homework/ui/home/ui/tabs/chat/store/chat_store.dart';
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
      return chatStore.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor, // Adjust loader color
              ),
            )
          :chatStore.allConversationResponse?.conversations?.length==0 ? Center(child: Text("Chat not yet",style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontSize: 12.spMin,
        fontWeight: FontWeight.w500,
      ),)) : ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              children: List.generate(
                chatStore.allConversationResponse?.conversations?.length ?? 0,
                (index) => ChatWidget(
                  image: chatData?[index].user?.image ?? "",
                  name: chatData?[index].user?.firstName ?? "",
                  lastMessage: chatData?[index].lastMessage?.text ?? "",
                  time: _formatTime(chatData?[index].lastMessage?.updatedAt),
                  conversationId: chatData?[index].Id ?? "",
                  receiverId: chatData?[index].user?.id ?? "",
                ),
              ),
            );
    });
  }
}

void showChatBottomSheet(BuildContext context) {
  showAppBottomSheet(context, const ChatPage());
}

void showAppBottomSheet(BuildContext context, Widget any,
    {VoidCallback? onClose}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: any,
    ),
  ).then((_) {
    onClose!();
  });
}

String _formatTime(String? timestamp) {
  if (timestamp == null) return '';

  final dateTime = DateTime.parse(timestamp);
  final now = DateTime.now();

  // Check if the date is today
  final isToday = dateTime.year == now.year &&
      dateTime.month == now.month &&
      dateTime.day == now.day;

  if (isToday) {
    // Format and return only the time if it's today
    return DateFormat.jm().format(dateTime); // Example: "12:15 PM"
  } else {
    // Format and return the date for other days
    return DateFormat.yMMMd().format(dateTime); // Example: "Jan 27, 2025"
  }
}

