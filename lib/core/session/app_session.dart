import 'package:balcony/core/session/session.dart';
import 'package:hive/hive.dart';

class AppSession implements Session {
  static const _appDbBox = '_appDbBox';
  final Box<dynamic> _box;

  AppSession._(this._box);

  static Future<AppSession> getInstance() async {
    final box = await Hive.openBox<dynamic>(_appDbBox);
    return AppSession._(box);
  }

  @override
  T getValue<T>(String key, {T? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue) as T;

  @override
  Future<void> setValue<T>(String key, T value) => _box.put(key, value);

  @override
  bool get isLogin => getValue("isLogin", defaultValue: false);

  @override
  set isLogin(bool update) => setValue("isLogin", update);

  @override
  String get token => getValue("token", defaultValue: "");

  @override
  set token(String update) => setValue("token", update);

  @override
  String get fcmToken => getValue("fcm_token", defaultValue: "0");

  @override
  set fcmToken(String update) => setValue("fcm_token", update);

  @override
  void logout() {
    token = "";
    isLogin = false;
  }
}
