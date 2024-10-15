abstract class Session {
  T getValue<T>(String key, {T? defaultValue});

  Future<void> setValue<T>(String key, T value);

  bool get isLogin;

  set isLogin(bool update);

  String get token;

  set token(String update);

  String get fcmToken;

  set fcmToken(String update);

  void logout();
}
