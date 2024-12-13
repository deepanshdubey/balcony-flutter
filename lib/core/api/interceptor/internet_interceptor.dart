import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class InternetInterceptors extends Interceptor {
  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(
        DioException(
          requestOptions: options,
          response: Response(
            statusCode: -9,
            statusMessage: "No Internet Connection",
            requestOptions: options,
          ),
        ),
      );
    }
    return handler.next(options);
  }
}
