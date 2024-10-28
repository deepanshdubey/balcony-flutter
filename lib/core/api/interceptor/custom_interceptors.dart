import 'package:balcony/core/session/app_session.dart';
import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (session.token.isNotEmpty) {
      options.headers
          .putIfAbsent("Authorization", () => "Bearer ${session.token}");
    }
    super.onRequest(options, handler);
  }
}
