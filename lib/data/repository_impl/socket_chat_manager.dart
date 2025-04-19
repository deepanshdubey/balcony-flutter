import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/constants.dart';
import 'package:homework/data/model/response/common_data.dart';
import 'package:homework/data/repository/chat_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class SocketChatManager implements ChatManager {
  static final SocketChatManager _instance = SocketChatManager._internal();

  factory SocketChatManager() => _instance;

  late socket_io.Socket _socket;
  bool _isConnected = false;
  void Function(CommonData message)? _activeChatHandler;

  SocketChatManager._internal();

  @override
  void connect({required String token, bool isAnonymous = false}) {
    if (_isConnected) {
      logger.i("Socket is already connected.");
      return;
    }

    final uri = isAnonymous
        ? Constants.webSocketUnAuthenticatedUrl
        : Constants.webSocketUrl;
    logger.i("Connecting to socket at: $uri");
    _socket = socket_io.io(uri, <String, dynamic>{
      'transports': ['websocket'],
      'sid': token,
      'EIO': '4',  // Add the EIO=4 query parameter
      'autoConnect': true,
      'extraHeaders': isAnonymous ? {} : {'Authorization': 'Bearer $token'},
    });

    _socket.onConnect((_) {
      _isConnected = true;
      logger.i("Socket connected successfully.");
    });

    _socket.onConnectError((error) {
      logger.e("Socket connect error: $error");
    });

    _socket.onError((error) {
      logger.e("Socket general error: $error");
    });

    _socket.on('getMessage', (data) {
      logger.d("Received message: $data");
      try {
        final message = CommonData.fromJson(data['message']);
        if (_activeChatHandler != null) {
          logger.d("Dispatching message to active handler.");
          _activeChatHandler!(message);
        } else {
          _handleMessageWhenInactive(message);
        }
      } catch (e, stack) {
        logger.e("Error parsing incoming message: $data", stackTrace: stack);
      }
    });

    _socket.on('eventError', (data) {
      logger.e("Socket eventError: ${data['message']}");
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      logger.w("Socket disconnected.");
    });
  }

  @override
  void disconnect() {
    if (_isConnected) {
      _socket.disconnect();
      _isConnected = false;
      logger.i("Socket disconnected manually.");
    } else {
      logger.i("Socket is already disconnected.");
    }
  }

  @override
  void addUser(String conversationId) {
    logger.d("Emitting 'addUser' with conversationId: $conversationId");
    _socket.emit('addUser', {'conversationId': conversationId});
  }

  @override
  void sendMessage(CommonData message) {
    logger.d("Sending message: ${message.toJson()}");
    _socket.emit('sendMessage', message.toJson());
  }

  @override
  void registerChatHandler(void Function(CommonData message) handler) {
    _activeChatHandler = handler;
    logger.i("Registered active chat handler.");
  }

  @override
  void unregisterChatHandler() {
    _activeChatHandler = null;
    logger.i("Unregistered chat handler.");
  }

  void _handleMessageWhenInactive(CommonData message) {
    logger.w('Message received when no handler is active: $message');
    // Optionally, store the message for later.
  }
}

var socketManager = locator<ChatManager>();
