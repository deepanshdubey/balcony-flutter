import 'package:homework/core/socket/socket_manager.dart';
import 'package:homework/data/model/response/socket_message.dart';
import 'package:flutter/material.dart';

class SocketProvider extends ChangeNotifier {
  final SocketManager _socketManager = SocketManager();
  List<SocketMessage> messages = [];
  bool isOnline = false;

  void initializeSocket() {
    _socketManager.initializeSocket('https://api.homework.ws');

    _socketManager.onGetMessage((data) {
      final message = SocketMessage.fromJson(data);
      messages.add(message);
      notifyListeners();
    });

    _socketManager.onGetUsers((data) {
      isOnline = data.any((user) => user['userId'] == 'currentUserId'); // Replace with actual userId
      notifyListeners();
    });
  }

  void addUser(String userId) {
    _socketManager.addUser(userId);
  }

  void sendMessage(SocketMessage message) {
    _socketManager.sendMessage(message.toJson());
    messages.add(message);
    notifyListeners();
  }

  @override
  void dispose() {
    _socketManager.disConnect();
    super.dispose();
  }
}
