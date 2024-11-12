import 'package:balcony/data/model/response/user_data.dart';

abstract class Session {
  T getValue<T>(String key, {T? defaultValue});

  Future<void> setValue<T>(String key, T value);

  bool get isWalkthroughSeen;

  set isWalkthroughSeen(bool update);

  bool get isLogin;

  set isLogin(bool update);

  bool get isLoginSkipped;

  set isLoginSkipped(bool update);

  String get token;

  set token(String update);

  String get fcmToken;

  set fcmToken(String update);

  UserData get user;

  set user(UserData update);

  String? get sessionCookie;

  set sessionCookie(String? update);

  void logout();
}
