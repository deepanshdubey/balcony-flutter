import 'package:hive/hive.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/core/session/session.dart';
import 'package:homework/data/model/response/user_data.dart';

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
  bool get prop => getValue("prop", defaultValue: true);

  @override
  set prop(bool update) => setValue("prop", update);

  @override
  String get token => getValue("token", defaultValue: "");

  @override
  set token(String update) => setValue("token", update);

  @override
  String get fcmToken => getValue("fcm_token", defaultValue: "0");

  @override
  set fcmToken(String update) => setValue("fcm_token", update);

  @override
  String? get sessionCookie => getValue("session_cookie", defaultValue: null);

  @override
  set sessionCookie(String? update) => setValue("session_cookie", update);

  @override
  void logout() {
    token = "";
    isLogin = false;
    isLoginSkipped = false;
    isWalkthroughSeen = false;
    sessionCookie = null;
    isConcierge = false;
  }

  @override
  bool get isWalkthroughSeen =>
      getValue("isWalkthroughSeen", defaultValue: false);

  @override
  set isWalkthroughSeen(bool update) => setValue("isWalkthroughSeen", update);

  @override
  bool get isLoginSkipped => getValue("isLoginSkipped", defaultValue: false);

  @override
  set isLoginSkipped(bool update) => setValue("isLoginSkipped", update);

  @override
  UserData get user => getValue("user");

  @override
  set user(UserData user) => setValue("user", user);

  @override
  bool get isConcierge => getValue("isConcierge", defaultValue: false);

  @override
  set isConcierge(bool update) => setValue("isConcierge", update);
}

final session = locator<Session>();
