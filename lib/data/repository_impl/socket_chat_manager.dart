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

    _socket = socket_io.io(uri, {
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': isAnonymous ? {

      } : {'Authorization': 'Bearer $token'},
      'query': {
        if (!isAnonymous) 'sid': token,
        'EIO': '4',
      },
    });

    _registerCoreEvents();
    _registerMessageEvents();
  }

  void _registerCoreEvents() {
    _socket.onConnect((_) {
      _isConnected = true;
      logger.i("Socket connected.");
    });

    _socket.onConnectError((error) {
      logger.e("Socket connect error: $error");
    });

    _socket.onError((error) {
      logger.e("Socket error: $error");
    });

    _socket.onDisconnect((_) {
      _isConnected = false;
      logger.w("Socket disconnected.");
    });
  }

  void _registerMessageEvents() {
    _socket.on('getMessage', (data) {
      logger.d("Received message: $data");
      try {
        final message = CommonData.fromJson(data['message']);
        if (_activeChatHandler != null) {
          logger.d("Dispatching to active handler.");
          _activeChatHandler!(message);
        } else {
          _handleMessageWhenInactive(message);
        }
      } catch (e, stack) {
        logger.e("Error parsing message", error: e, stackTrace: stack);
      }
    });

    _socket.on('eventError', (data) {
      logger.e("Socket event error: ${data['message']}");
    });
  }

  @override
  void disconnect() {
    if (_isConnected) {
      _socket.disconnect();
      _isConnected = false;
      logger.i("Socket manually disconnected.");
    } else {
      logger.i("Socket already disconnected.");
    }
  }

  @override
  void addUser(String conversationId) {
    if (!_isConnected) {
      logger.w("Cannot add user. Socket is not connected.");
      return;
    }
    logger.d("Emitting 'addUser' with conversationId: $conversationId");
    _socket.emit('addUser', {'conversationId': conversationId});
  }

  @override
  void sendMessage(CommonData message) {
    if (!_isConnected) {
      logger.w("Cannot send message. Socket is not connected.");
      return;
    }
    logger.d("Emitting 'sendMessage': ${message.toJson()}");
    _socket.emit('sendMessage', message.toJson());
  }

  @override
  void registerChatHandler(void Function(CommonData message) handler) {
    _activeChatHandler = handler;
    logger.i("Chat handler registered.");
  }

  @override
  void unregisterChatHandler() {
    _activeChatHandler = null;
    logger.i("Chat handler unregistered.");
  }

  void _handleMessageWhenInactive(CommonData message) {
    logger.w("Received message with no active handler: $message");
    // Store it in local cache or DB if needed.
  }
}

var socketManager = locator<ChatManager>();
