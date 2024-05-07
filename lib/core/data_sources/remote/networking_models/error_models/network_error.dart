import 'package:dio/dio.dart';

import 'index.dart';

/// Gets thrown on http network errors
class NetworkError extends DioError {
  /// Type of the error is decided based on response status code
  final NetworkErrorType errorType;
  final String errorMessage;
  final bool? success;
  final Map<String, dynamic>? errorMessages;

  NetworkError({
    required super.requestOptions,
    required this.errorType,
    required this.errorMessage,
    this.success,
    this.errorMessages,
    super.error,
  });

  /// Creates [NetworkError] instance based on the [statusCode]
  factory NetworkError.errorFromCode(
      {required RequestOptions options,
      required int statusCode,
      required dynamic error,
      required String errorMessage,
      bool? success,
      Map<String, dynamic>? errorMessages}) {
    return NetworkError(
        requestOptions: options,
        error: error,
        errorType: NetworkErrorType.getType(statusCode),
        errorMessage: errorMessage,
        success: success,
        errorMessages: errorMessages);
  }
}
