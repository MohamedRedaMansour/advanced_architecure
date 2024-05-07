import 'dart:io';
import 'dart:ui';
import 'package:advanced_architecture_demo/core/data_sources/remote/extensions/map_encoder_ext.dart';
import 'package:dio/dio.dart';
import '../../constants/api_constants/apis.dart';
import '../../utils/tools/helper.dart';
import 'network_manager.dart';
import 'networking_models/index.dart';

/// Implements different interceptors to handle [onRequest], [onError], [onResponse]
class CustomInterceptor extends QueuedInterceptorsWrapper {
  NetworkAuthDelegate? auth;
  Locale? locale;
  Dio dio;

  CustomInterceptor(this.dio, {this.auth, this.locale});

  /// Maps the errors into [NetworkError] and send it back to the target
  ///
  /// except for [NetworkErrorType.unauthorized] will lock requests and try to update the token
  /// and send the request again.
  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response != null) {
      networkLogger.e('Response HttpStatusCode: ${err.response?.statusCode}');
      final error = NetworkError.errorFromCode(
        options: err.requestOptions,
        statusCode: err.response!.statusCode!,
        error: err.error,
        errorMessages:
            (err.response!.data is Map) ? err.response!.data['error'] : {},
        errorMessage: (err.response!.data is Map)
            ? err.response!.data['message'].toString()
            : '',
        success:
            (err.response!.data is Map) ? err.response!.data['success'] : false,
      );
      // if (error.errorType == NetworkErrorType.unauthorized) {
      //   _handleUnauthorized(error, handler);
      // } else {
        handler.next(error);
      // }
    } else {
      handler.next(
        NetworkError.errorFromCode(
          options: err.requestOptions,
          statusCode: err.response?.statusCode ??
              NetworkErrorType.noInternetConnection.statusCode,
          error: err.error,
          errorMessages:
              (err.response?.data is Map) ? err.response!.data['error'] : {},
          errorMessage: err.message??"",
          success: (err.response?.data is Map)
              ? err.response?.data['success']
              : false,
        ),
      );
    }
  }

  /// Verifies that the received response is valid otherwise `throw` [NetworkError] with [NetworkErrorType.responseExposed]
  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    networkLogger.i('Response HttpStatusCode\n${response.statusCode}');
    if(response.data is Map){
    networkLogger.i('Response Body\n${(response.data as Map).toJson()}');
    }
    networkLogger.i('Response Headers\n${response.headers.map.toJson()}');
    try {
//todo validate response for security resons

      handler.next(response);
    } catch (e) {
      handler.reject(
        NetworkError.errorFromCode(
            options: response.requestOptions,
            statusCode: NetworkErrorType.responseExposed.statusCode,
            error: 'Response is invalid',
            errorMessage: response.statusMessage ?? ''),
      );
    }
  }



  /// Injects token, language, and signKey values in header before the request is sent to the API
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _appendAuthHeader(options.headers , options.baseUrl);

    networkLogger.i('Sending request to\n${options.uri.toString()}');
    networkLogger.i('Request header\n${options.headers.toJson()}');
    if(options.data is Map) {
      networkLogger.i(
        'Request body\n${options.data != null
            ? (options.data as Map).toJson()
            : {}}',
      );
    }
    ///call api if internet is available and endpoint is not force update
    ///in force update we will navigate to specific page when app open
    /// else show toast message
    if (await CommonHelper().checkInternetConnectivity() == true) {
      handler.next(options);
    }else{
      ///show SnackBar
    }
  }


  Future<void> _appendAuthHeader(Map<String, dynamic> headers , String baseUrl ) async {
    // final language = locale?.languageCode;
    headers[HeaderConst.originHeader] = baseUrl.substring(0, baseUrl.length - 1);
    headers[HeaderConst.platformHeader] = 'Flutter';
    headers[HeaderConst.deviceType] = Platform.isIOS ? 'ios' : 'android';
    final token = await auth?.getToken();
    if (token != null && token != '') {
      headers[HeaderConst.authHeader] = 'Bearer $token';
      headers[HeaderConst.token] = 'Bearer $token';
    }
  }
}
