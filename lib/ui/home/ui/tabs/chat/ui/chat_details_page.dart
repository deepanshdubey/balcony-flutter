import 'dart:io';

import 'package:homework/core/session/app_session.dart';
import 'package:homework/core/socket/socket_manager.dart';
import 'package:homework/data/model/response/conversation_data.dart';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:homework/ui/home/ui/tabs/chat/store/chat_store.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class ChatDetailsPage extends StatefulWidget {
  final String? receiverId;
  final String? conversationId;
  final String? image;
  final String? name;

  ChatDetailsPage(
      {super.key, this.receiverId, this.conversationId, this.image, this.name});

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final messageController = TextEditingController();
  final SocketManager socketManager = SocketManager();
  final ValueNotifier<List<LastMessage>> messages = ValueNotifier([]);
  ValueNotifier<bool> isReceiverOnline = ValueNotifier(false);
  final chatStore = ChatStore();
  List<ReactionDisposer>? disposers;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
    chatStore.getAllMsg(widget.conversationId ?? " ");
    addDisposer();
  }

  @override
  void dispose() {
    socketManager.disConnect();
    messageController.dispose();
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => chatStore.allMsgResponse, (response) {
        messages.value = chatStore.allMsgResponse?.messages ?? [];
        _scrollToBottom();

      }),
      reaction((_) => chatStore.createMsgResponse, (response) {
        final socketMessage = {
          "senderId": session.user.id ?? "",
          "receiverId": widget.receiverId ?? "",
          "text": messageController.text.trim().isNotEmpty
              ? messageController.text.trim()
              : null, // Only include text if it's not empty
          "media": response?.media?.isNotEmpty == true
              ? {
            "url": response?.media?[0].url,
            "type": response?.media?[0].type,
          }
              : null,  // If no media, set it to null
          "seen": false,
        };


        socketManager.sendMessage(socketMessage);
        print("send chat--> $socketMessage");


        final newMessage = LastMessage(
          senderId: session.user.id ?? "",
          text: messageController.text.trim(),
          media: Media(url:response?.media?[0].url, type: response?.media?[0].url), // Use the file URL or upload it if needed
          createdAt: DateTime.now().toIso8601String(),
        );
        messageController.clear();
        messages.value = [...messages.value, newMessage];
      }),
    ];
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.bounceIn,
        );
      }
    });
  }

  void removeDisposer() {
    if (disposers == null) return;
    for (final element in disposers!) {
      element.reaction.dispose();
    }
  }

  Future<void> _initializeChat() async {
    socketManager.initializeSocket(
        "https://api.homework.ws/"); // Replace with socket URL
    socketManager.addUser(session.user.id ?? "");

    socketManager.onGetMessage((data) {
      print("Get chat--> $data");

      Media? media; // Initialize as null (optional)
      if (data['media'] != null && data['media'].isNotEmpty) {
        final mediaData = data['media'][0];
        media = Media.fromJson({
          'fieldname': 'media', // Static value
          'url': mediaData['url'],
          'type': mediaData['type'],
        });
      }
      final messageWithTime = LastMessage(
        senderId: data['senderId'],
        text: data['text'] ?? '',
        media: media,
        createdAt: DateTime.now().toIso8601String(), // Current time
      );

      if (data['senderId'] != session.user.id) {
        messages.value = [...messages.value, messageWithTime];
      }
      _scrollToBottom();
    });



    socketManager.onGetUsers((users) {
      isReceiverOnline.value =
          users.any((user) => user['userId'] == widget.receiverId);
    });
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    chatStore.createMsg(
        conversationId: widget.conversationId ?? "",
        msg: messageController.text.trim());


    _scrollToBottom();
  }

  Future<void> _pickAndSendImage() async {
    // Pick an image file
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to images
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path ?? '');

      // Upload media or send the image message (depending on your app's requirements)
      await chatStore.createMsg(
        conversationId: widget.conversationId ?? "",
        media: file, // Send the file as media
      );

      _scrollToBottom();
    }
  }


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
            url: widget.image,
          ),
          10.w.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name ?? "",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 17.spMin,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: isReceiverOnline,
                builder: (context, value, child) {
                  return Text(
                    value ? 'Online' : 'offline',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 12.spMin,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    return ValueListenableBuilder<List<LastMessage>>(
      valueListenable: messages,
      builder: (context, messageList, _) {
        return ListView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: messageList.length,
          itemBuilder: (context, index) {
            final message = messageList[index];
            if (message.senderId == session.user.id) {
              return _buildSentMessage(
                  context: context,
                  time: _formatTime(message.createdAt),
                  text: message.text,
                  mediaUrl: message.media?.url);
            } else {
              return _buildReceivedMessage(
                  time: _formatTime(message.createdAt),
                  text: message.text,
                  mediaUrl: message.media?.url);
            }
          },
        );
      },
    );
  }


// Widget to build sent message
  Widget _buildSentMessage({
    required BuildContext context,
    String? text,
    required String time,
    String? mediaUrl, // URL for image or file path
  }) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Display text if available
          if (text != null && text.isNotEmpty)
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
            )
          // Display image if mediaUrl is available
          else if (mediaUrl != null && mediaUrl.isNotEmpty)
            AppImage(
              url: mediaUrl.startsWith('file://')
                  ? null
                  : mediaUrl,  // If it's a local file, pass null for URL
              file: mediaUrl.startsWith('file://')
                  ? mediaUrl.replaceFirst('file://', '')
                  : null,  // Extract the local file path
              height: 200.r,
              width: 200.r,
              radius: 10.r,
            )
          else
            const SizedBox.shrink(),  // Empty space if no media or text
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }



  Widget _buildReceivedMessage(
      {String? text, required String time, String? mediaUrl}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // If text is available, display it. Otherwise, show media.
          text != null && text.isNotEmpty
              ? Container(
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
                )
              : mediaUrl != null && mediaUrl.isNotEmpty
                  ? AppImage(
                      url: mediaUrl,
                      height: 200.r,
                      width: 200.r,
                      radius: 10.r,
                    )
                  : const SizedBox.shrink(),
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
          onFieldSubmitted: (p0) {
            _sendMessage();
          },
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
              onPressed: _pickAndSendImage,
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

  String _formatTime(String? timestamp) {
    if (timestamp == null) return '';
    final dateTime = DateTime.parse(timestamp);
    final formattedTime =
        DateFormat.jm().format(dateTime); // Example: "12:15 PM"
    return formattedTime;
  }
}
