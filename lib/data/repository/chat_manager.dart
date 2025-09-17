import 'package:homework/data/model/response/common_data.dart';

abstract class ChatManager {
  void connect({required String token, bool isAnonymous});

  void disconnect();

  void addUser(String conversationId);

  void sendMessage(CommonData message);

  void registerChatHandler(void Function(CommonData message) handler);

  void unregisterChatHandler();
}
