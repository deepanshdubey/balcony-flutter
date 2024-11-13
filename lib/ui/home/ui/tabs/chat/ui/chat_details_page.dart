import 'package:balcony/generated/assets.dart';
import 'package:balcony/widget/app_back_button.dart';
import 'package:balcony/widget/app_image.dart';
import 'package:balcony/widget/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDetailsPage extends StatelessWidget {
  ChatDetailsPage({super.key});

  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildCustomAppBar(context),
          Expanded(child: _buildChatList(context)),
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          AppBackButton(
            text: "back to chats",
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
          AppImage(
            radius: 21.r,
            assetPath: Assets.dummyChatUser,
          ),
          10.w.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pranav Ray',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 17.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Online',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSentMessage(context, 'Hey! How have you been?', '12:15 PM'),
        _buildSentMessage(context, 'Wanna catch up for a beer?', '12:15 PM'),
        _buildReceivedMessage('Awesome! Let\'s meet up', '12:20 PM'),
        _buildReceivedMessage(
            'Can I also get my cousin along?\nWill that be okay?', '12:20 PM'),
        _buildSentMessage(context, 'Yeah sure! get him too.', '12:22 PM'),
        _buildReceivedMessage('Alright! See you soon!', '12:25 PM'),
        _buildVoiceMessage('12:25 PM', isReceived: true),
        _buildSentMessage(context, 'okay sure!', '12:25 PM'),
      ],
    );
  }

  Widget _buildSentMessage(BuildContext context, String text, String time) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(String text, String time) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage(String time, {bool isReceived = false}) {
    return Align(
      alignment: isReceived ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: isReceived ? Colors.grey.shade200 : Colors.teal.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.white.withOpacity(0.3),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: AppTextField(
          controller: messageController,
          inputDecoration: InputDecoration(
            hintText: "Type Message",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide:
                    BorderSide(color: theme.primaryColor.withOpacity(.2))),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            filled: false,
            fillColor: Colors.grey[200],
            // Background color of the text field
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
            prefixIcon: IconButton(
              onPressed: () {},
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic, color: Colors.white),
              ),
            ),
          ),
          label: '',
          showLabelAboveField: false,
        ),
      ),
    );
  }
}