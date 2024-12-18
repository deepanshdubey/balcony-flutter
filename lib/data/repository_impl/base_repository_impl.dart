import 'dart:io';

import 'package:homework/core/api/api_response/api_exception.dart';
import 'package:homework/core/api/api_response/api_response.dart';
import 'package:homework/core/locator/locator.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseRepositoryImpl {
  Future<ApiResponse<T>> execute<T>(Future<T> apiCall) async {
    try {
      final response = await apiCall;
      return ApiResponse<T>(data: response);
    } on DioException catch (dioError) {
      final error = handleDioException(dioError);
      return ApiResponse<T>(error: error);
    } catch (e, st) {
      logger.e(st);
      return ApiResponse<T>(
          error: ApiException(statusCode: -1, message: "Something went wrong"));
    }
  }

  ApiException handleDioException(DioException error) {
    // Handle specific DioException types
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(statusCode: -1, message: "Connection timed out");
      case DioExceptionType.sendTimeout:
        return ApiException(statusCode: -1, message: "Send timeout");
      case DioExceptionType.receiveTimeout:
        return ApiException(statusCode: -1, message: "Receive timeout");
      case DioExceptionType.badCertificate:
        return ApiException(statusCode: -1, message: "Bad certificate");
      case DioExceptionType.badResponse:
        return handleBadResponse(error);
      case DioExceptionType.cancel:
        return ApiException(statusCode: -1, message: "Request canceled");
      case DioExceptionType.connectionError:
        return ApiException(statusCode: -1, message: "Connection error");
      case DioExceptionType.unknown:
        return ApiException(statusCode: -1, message: "Unknown error");
    }

    // Default fallback for unknown errors
    return ApiException(statusCode: -1, message: "Unknown error");
  }

  ApiException handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode ?? -1;
    String? message;

    if (error.response?.data is Map<String, dynamic>) {
      message = error.response?.data['message'] ?? message;
    }

    // Handle specific status codes
    switch (statusCode) {
      case 500:
        return ApiException(
          statusCode: statusCode,
          message: message ?? "Internal server error. Please try again later.",
        );
      case 401:
        return ApiException(
          statusCode: statusCode,
          message: message ?? error.message ?? '401',
        );
      case 403:
        return ApiException(
          statusCode: statusCode,
          message:
              message ?? "Forbidden. You don't have permission to access this resource.",
        );
      case 404:
        return ApiException(
          statusCode: statusCode,
          message: message ?? "Resource not found.",
        );
      case 422:
        return ApiException(
          statusCode: statusCode,
          message: message ?? "Unprocessable Entity. Please check the submitted data.",
        );
      default:
        return ApiException(
          statusCode: statusCode,
          message: message ?? "Something went wrong",
        );
    }
  }

  Future<List<MultipartFile>> prepareImageFiles(List<File> images) async {
    return Future.wait(
      images.map((image) async {
        return await MultipartFile.fromFile(
          image.path,
          contentType: MediaType('image',
              image.path.split("/").last), // Adjust MIME type if needed
        );
      }).toList(),
    );
  }
}
