import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:balcony/core/api/interceptor/custom_interceptors.dart';
import 'package:balcony/core/locator/locator.dart';
import 'package:balcony/data/remote/api_client.dart';

class ApiModule {
  Future<void> provides() async {
    final dio = await setup();
    locator.registerSingleton<Dio>(dio);
    final apiClient = ApiClient(dio);
    locator.registerSingleton<ApiClient>(apiClient);
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
