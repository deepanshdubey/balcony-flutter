import 'dart:io';

import 'package:balcony/core/locator/locator.dart';
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
    if (session.isLogin) {
      options.headers
          .putIfAbsent("Cookie", () => "token=${session.token}");
    } else if (session.sessionCookie != null) {
      options.headers
          .putIfAbsent("Cookie", () => "connect.sid=${session.sessionCookie}");
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Extract the `connect.sid` cookie from the response headers
    final cookies = response.headers[HttpHeaders.setCookieHeader];
    if (cookies != null) {
      for (var cookie in cookies) {
        if (cookie.startsWith('connect.sid=')) {
          session.sessionCookie = cookie.split(';')[0].split('=')[1];
          break;
        }
      }
    }

    return handler.next(response);
  }
}
