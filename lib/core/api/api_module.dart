import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:homework/data/remote/chat_api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:homework/core/api/interceptor/custom_interceptors.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:homework/data/remote/api_client.dart';

class ApiModule {
  Future<void> provides() async {
    final dio = await setup();
    locator.registerSingleton<Dio>(dio);
    final apiClient = ApiClient(dio);
    locator.registerSingleton<ApiClient>(apiClient);
    final chatApiClient = ChatApiClient(dio);
    locator.registerSingleton<ChatApiClient>(chatApiClient);
  }

  static FutureOr<Dio> setup() async {
    final Dio dio = Dio()
      ..options = BaseOptions(
        responseType: ResponseType.json,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );



    dio.interceptors.add(CustomInterceptors());

    // Add PrettyDioLogger for debugging purposes
    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
        ),
      );
    }

    return dio;


  }
}
