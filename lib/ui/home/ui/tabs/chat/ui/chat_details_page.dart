import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/app_session.dart';
import 'package:homework/data/model/response/message_data.dart';
import 'package:homework/data/repository_impl/socket_chat_manager.dart';
import 'package:homework/ui/home/ui/tabs/chat/store/chat_store.dart';
import 'package:homework/ui/home/ui/tabs/chat/ui/audio_player.dart';
import 'package:homework/widget/app_back_button.dart';
import 'package:homework/widget/app_image.dart';
import 'package:homework/widget/app_text_field.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

class ChatDetailsPage extends StatefulWidget {
  final String? receiverId;
  final String? conversationId;
  final String? image;
  final String? name;
  final bool fetchChatHistory;

  const ChatDetailsPage({
    super.key,
    this.receiverId,
    this.conversationId,
    this.image,
    this.name,
    this.fetchChatHistory = false,
  });

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final ValueNotifier<bool> _isRecording = ValueNotifier<bool>(false);
  late RecorderController _recorderController;
  final messageController = TextEditingController();
  final ValueNotifier<List<MessageData>> messages = ValueNotifier([]);
  ValueNotifier<bool> isReceiverOnline = ValueNotifier(false);
  final chatStore = ChatStore();
  List<ReactionDisposer>? disposers;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeChat();
    initialiseControllers();
    if (widget.fetchChatHistory)
      chatStore.getAllMsg(widget.conversationId ?? " ");
    addDisposer();
  }

  Future<void> initialiseControllers() async {
    _recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.amr_nb
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..bitRate = 256000 // Increase bitrate to improve quality
      ..sampleRate = 44100;
  }

  Future<void> startRecording() async {
    try {
      if (await _recorderController.checkPermission()) {
        await _recorderController.record(); // Start recording
      }
    } catch (e) {
      print('Error recording: $e');
    }
  }

  Future<void> stopRecording() async {
    var path = await _recorderController.stop() ??
        ''; // Get the file path after stopping the recording
    if (path.isNotEmpty) {
      print('Recording saved at: $path');
      await uploadAudio(path); // Upload the audio file
    }
  }

  void _toggleRecording() {
    _isRecording.value = !_isRecording.value;
    if (_isRecording.value) {
      startRecording();
    } else {
      stopRecording();
    }
  }

  Future<void> uploadAudio(String filePath) async {
    final file = File(filePath);

    if (file.existsSync()) {
      /*await chatStore.createMsgMedia(
        conversationId: widget.conversationId ?? "",
        media: file,
        type: 'audio', // Specify the media type as audio
      );
      _scrollToBottom();*/
    }
  }

  @override
  void dispose() {
    socketManager.disconnect();
    messageController.dispose();
    _isRecording.dispose();
    removeDisposer();
    super.dispose();
  }

  void addDisposer() {
    disposers ??= [
      reaction((_) => chatStore.allMsgResponse, (response) {
        messages.value = chatStore.allMsgResponse?.messages ?? [];
        _scrollToBottom();
      }),
      /* reaction((_) => chatStore.createMsgResponse, (response) {
        final socketMessage = {
          "senderId": session.user.id ?? "",
          "receiverId": widget.receiverId ?? "",
          "text": messageController.text.trim().isNotEmpty
              ? messageController.text.trim()
              : null, // Only include text if it's not
          // empty
          if (response?.media?.url != null)
            "media": {
              "url": response?.media?.url,
              "type": response?.media?.type,
            }, // If no media, set it to null
          "seen": false,
        };

        socketManager.sendMessage(socketMessage);
        print("send chat--> $socketMessage");

        final newMessage = MessageData(
          senderId: session.user.id ?? "",
          text: messageController.text.trim(),
          media:
              MediaData(url: response?.media?.url, type: response?.media?.url),
          // Use the file URL or upload it if needed
          createdAt: DateTime.now().toIso8601String(),
        );
        messageController.clear();
        messages.value = [...messages.value, newMessage];
      }),*/
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
    socketManager.connect(token: session.token, isAnonymous: session.isLogin);

    socketManager.registerChatHandler(
      (message) {
        logger.e(message.toJson());
      },
    );

    /* socketManager.registerChatHandler((data) {
      print(data);

      MediaData? media;
      if (data['media'] != null &&
          data['media'] is List &&
          data['media'].isNotEmpty) {
        final mediaData =
            data['media'][0]; // Access the first media object in the list
        media = MediaData.fromJson({
          'fieldname': 'media',
          'url': mediaData['url'],
          'type': mediaData['type'],
        });
      }

      final messageWithTime = MessageData(
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
      print(users);

      isReceiverOnline.value =
          users.any((user) => user['userId'] == session.user.id);

      print(session.user.id);

      print(widget.receiverId);

      print(isReceiverOnline.value);
    });*/
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;
    /*chatStore.createMsg(
        conversationId: widget.conversationId ?? "",
        msg: messageController.text.trim());*/

    _scrollToBottom();
  }

  Future<void> _pickAndSendImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Restrict to images
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path ?? '');
      /*await chatStore.createMsgMedia(
          conversationId: widget.conversationId ?? "",
          media: file,
          type: "image" // Send the file as media
          );
*/
      _scrollToBottom();
    }
  }

  // Future<void> _pickAndSendVideo() async {
  //   final result = await FilePicker.platform.pickFiles(
  //     type: FileType.video, // Restrict to video files
  //     allowMultiple: false,
  //   );
  //
  //   if (result != null && result.files.isNotEmpty) {
  //     final file = File(result.files.single.path ?? '');
  //     await chatStore.createMsgMediaData(
  //       conversationId: widget.conversationId ?? "",
  //       media: file, // Send the file as media
  //     );
  //
  //     _scrollToBottom();
  //   }
  // }

  /*Future<void> _pickAndSendDocument() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom, // Restrict to custom types (documents)
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'], // Allowed extensions (optional)
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path ?? '');
      await chatStore.createMsgMediaData(
        conversationId: widget.conversationId ?? "",
        media: file,
        type: "document"// Send the file as media
      );

      _scrollToBottom();
    }
  }*/

  // void _showPickOptions() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.image, color: Theme.of(context).primaryColor),
  //               title: Text('Pick an Image'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickAndSendImage();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.video_collection, color: Theme.of(context).primaryColor),
  //               title: Text('Pick a Video'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickAndSendVideo();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.description, color: Theme.of(context).primaryColor),
  //               title: Text('Pick a Document'),
  //               onTap: () {
  //                 Navigator.pop(context);
  //                 _pickAndSendDocument();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

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
    return ValueListenableBuilder<List<MessageData>>(
      valueListenable: messages,
      builder: (context, messageList, _) {
        if (messageList.isEmpty) {
          return chatStore.isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(child: Text("No messages yet. Start a conversation!"));
        } else {
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
                  mediaUrl: message.media?.url,
                );
              } else {
                return _buildReceivedMessage(
                  time: _formatTime(message.createdAt),
                  text: message.text,
                  mediaUrl: message.media?.url,
                );
              }
            },
          );
        }
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
            mediaUrl.endsWith(".mp3") ||
                    mediaUrl.endsWith(".wav") ||
                    mediaUrl.endsWith(".m4a")
                ? AudioPlayerWidget(audioUrl: mediaUrl) // Display audio player
                : AppImage(
                    url: mediaUrl.startsWith('file://') ? null : mediaUrl,
                    // If it's a local file, pass null for URL
                    file: mediaUrl.startsWith('file://')
                        ? mediaUrl.replaceFirst('file://', '')
                        : null,
                    // Extract the local file path
                    height: 200.r,
                    width: 200.r,
                    radius: 10.r,
                  )
          else
            const SizedBox.shrink(), // Empty space if no media or text
          const SizedBox(height: 5),
          Text(
            time,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage({
    String? text,
    required String time,
    String? mediaUrl,
  }) {
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
                  ? mediaUrl.endsWith(".mp3") ||
                          mediaUrl.endsWith(".wav") ||
                          mediaUrl.endsWith(".m4a") ||
                          mediaUrl.endsWith(".webm")
                      ? AudioPlayerWidget(
                          audioUrl: mediaUrl) // Display audio player
                      : AppImage(
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
            /*suffixIcon: IconButton(
              onPressed: _pickAndSendImage,
              icon: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),*/
            // prefixIcon: IconButton(
            //   onPressed: () {
            //
            //
            //
            //   },
            //
            //
            //   icon: ValueListenableBuilder<bool>(
            //     valueListenable: _isRecording,
            //     builder: (context, isRecording, child) {
            //       return IconButton(
            //         icon: Icon (
            //           isRecording ? Icons.stop : Icons.mic,
            //           color: theme.primaryColor,
            //         ),
            //         onPressed: _toggleRecording,
            //       );
            //     },
            //   ),
            // ),
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
