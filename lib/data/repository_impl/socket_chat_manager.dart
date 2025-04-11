import 'package:flutter/foundation.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/repository/chat_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketChatManager implements ChatManager {
  static final SocketChatManager _instance = SocketChatManager._internal();

  factory SocketChatManager() => _instance;

  late IO.Socket _socket;
  bool _isConnected = false;
  void Function(CommonData message)? _activeChatHandler;

  SocketChatManager._internal();

  @override
  void connect({required String token, bool isAnonymous = false}) {
    if (_isConnected) return;

    final uri =
        isAnonymous ? 'https://api.hw.co/anonymous' : 'https://api.hw.co/';

    _socket = IO.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': isAnonymous ? {} : {'Authorization': 'Bearer $token'},
    });

    _socket.onConnect((_) {
      _isConnected = true;
      debugPrint("Socket connected");
    });

    _socket.on('getMessage', (data) {
      final message = CommonData.fromJson(data['message']);
      if (_activeChatHandler != null) {
        _activeChatHandler!(message);
      } else {
        _handleMessageWhenInactive(message);
      }
    });

    _socket.on('eventError', (data) {
      debugPrint("Socket error: ${data['message']}");
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      debugPrint("Socket disconnected");
    });
  }

  @override
  void disconnect() {
    if (_isConnected) {
      _socket.disconnect();
      _isConnected = false;
    }
  }

  @override
  void addUser(String conversationId) {
    _socket.emit('addUser', {'conversationId': conversationId});
  }

  @override
  void sendMessage(CommonData message) {
    _socket.emit('sendMessage', message.toJson());
  }

  @override
  void registerChatHandler(void Function(CommonData message) handler) {
    _activeChatHandler = handler;
  }

  @override
  void unregisterChatHandler() {
    _activeChatHandler = null;
  }

  void _handleMessageWhenInactive(CommonData message) {
    logger.d('Message received when not active: $message');
  }
}
