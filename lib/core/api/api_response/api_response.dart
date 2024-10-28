import 'package:balcony/core/api/api_response/api_exception.dart';

class ApiResponse<T> {
  final T? data;
  final ApiException? error;

  ApiResponse({this.data, this.error});

  bool get isSuccess => error == null;

  bool get isFailure => !isSuccess;
}
