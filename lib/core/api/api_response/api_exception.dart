class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({required this.statusCode, required this.message});

  factory ApiException.fromJson(Map<String, dynamic> json, int statusCode) {
    return ApiException(
      statusCode: statusCode,
      message: json['message'] ?? 'An unknown error occurred',
    );
  }
}
