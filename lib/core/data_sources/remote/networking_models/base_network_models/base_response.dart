

import '../error_models/index.dart';

/// Wraps the response data, status code, message, and sign key
///
class BaseResponse<T> {
  BaseResponse(
      {int? code,
      NetworkErrorType? httpStatusCode,
      this.message,
      this.data,
      this.signKey,
      this.success,
      this.errorMessages}) {
    _code = code;
    _httpStatusCode = httpStatusCode;
  }

  /// Response code by remote server
  late final int? _code;

  late final NetworkErrorType? _httpStatusCode;

  /// Response message for error if any
  final String? message;

  final String? signKey;
  final bool? success;
  final Map<String, dynamic>? errorMessages;

  int get code => (_code ?? _httpStatusCode?.statusCode) ?? 5;

  /// Response data if success
  final T? data;

  // Returns `true` if the error happened is HttpError
  bool get _hasHttpError =>
      _httpStatusCode != null &&
      !(_httpStatusCode!.statusCode >= 200 &&
          _httpStatusCode!.statusCode <= 300);

  // Returns `true` if the error happened caused by the server
  bool get _hasServerSideError => _code != null && _code! > 0;

  /// Returns `true` if response has an error and `false` otherwise.
  bool get hasError {
    if(_code==null){
      return false;
    }
    return  _code != 200;
  }
}
