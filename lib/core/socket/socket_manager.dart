import 'package:dio/dio.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  late IO.Socket socket;
  final Dio dio = Dio(BaseOptions(baseUrl: "https://api.homework.ws/api/v2"));

  void initializeSocket(String url) {
    socket = IO.io(url, IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build());

    socket.onConnect((_) {
      print("Connected to Socket.IO server");
    });

    socket.onDisconnect((_) {
      print("Disconnected from Socket.IO server");
    });
  }

  void addUser(String userId) {
    socket.emit('addUser', userId);
  }

  void sendMessage(Map<String, dynamic> message) {
    socket.emit('sendMessage', message);
  }

  void onGetMessage(Function(dynamic) callback) {
    socket.on('getMessage', callback);
  }

  void onGetUsers(Function(List<dynamic>) callback) {
    socket.on('getUsers', (data) => callback(data));
  }


  void disConnect(){
    socket.dispose();
  }
}
