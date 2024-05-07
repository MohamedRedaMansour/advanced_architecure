import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';
import '../../../main.dart';
import '../../constants/api_constants/apis.dart';
import 'custom_interceptor.dart';
import 'network_decoder.dart';
import 'networking_models/base_network_models/base_network_deserializable.dart';
import 'networking_models/base_network_models/base_response.dart';
import 'networking_models/config_models/global_network_config.dart';
import 'networking_models/config_models/request_type.dart';
import 'networking_models/config_models/route_config.dart';
import 'networking_models/error_models/network_error.dart';
import 'networking_models/error_models/network_error_type.dart';

import '../../../features/bloc/localization/localization_cubit.dart';

/// Logs network related errors / information
final networkLogger = Logger(
  printer: PrettyPrinter(
    lineLength: 110,
    methodCount: 0,
  ),
);

/// **Handles http request & configuring the http client**
///
/// Singleton Class
///
class NetworkManager {
  NetworkManager._internal() {
    _dio = Dio();
  }

  static final NetworkManager instance = NetworkManager._internal();
  late Dio _dio;
  GlobalNetworkConfig config = GlobalNetworkConfig();

  /// Configures the network manager using [GlobalNetworkConfig] instance
  ///
  /// which adds global configuration and callbacks to invoke when
  /// the token expires / invalid request detected
  void configure(GlobalNetworkConfig config) {
    this.config = config;
    _setupDio();
  }

  /// Configures the dio client by adding base options and SSL Pinning and adding the interceptors
  void _setupDio() {
    _dio.options = BaseOptions(
      baseUrl: config.baseUrl,
    );
    _setupSSLPinning();
    _setupInterceptors();
  }

  /// Enables SSL Pinning if [config.enableSSLPinning] is true
  void _setupSSLPinning() {
    if (config.enableSSLPinning) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          if (cert.pem == config.certificatePath) {
            // Verify the certificate
            return true;
          }
          return false;
        };
        return client;
      };
    }
  }

  /// Adds interceptors to the dio client
  void _setupInterceptors() {
    _dio.interceptors.clear();
    _dio.interceptors.add(
      CustomInterceptor(
        _dio,
        auth: config.auth,
        locale: LocalizationCubit.initialLocale,
      ),
    );
  }

  /// **Makes any kind of http requests**
  ///
  /// Takes two generic data types [T] which must extend [BaseNetworkDeserializable] which is the data model class
  /// for the response and [K] which is the actual return type of the request
  /// for example you might have a request that returns a List of TodoItems
  /// ```dart
  /// request<TodoItem, List<TodoItem>(..);
  /// ```
  /// where TodoItem must be a subclass for [BaseNetworkDeserializable]
  ///
  /// Uses [routeConfig] object to get the path, the method, and different configurations and
  /// uses [responseType] instance of type [T] to parse the object from Json
  /// [networkOptions] contains callback used to receive progress
  ///
  /// Returns [BaseResponse] which wraps the data of type [K]
  ///
  /// Throws [NetworkError] if request is failed
  Future<BaseResponse<K?>> request<T extends BaseNetworkDeserializable, K>(
    RouteConfig routeConfig,
    T responseType,
  ) async {
    final headers = _setupHeaders(routeConfig);
    try {
      Response<dynamic> response;
      if (routeConfig.requestType == RequestType.upload) {
        response = await _handleUpload(routeConfig, headers);
      } else {
        response = await _handleRequest(routeConfig, headers);
      }
      return NetworkDecoder.shared
          .decode<T, K>(response: response, responseType: responseType);
    } on NetworkError catch (error, stackTrace) {
      networkLogger.e(error);
      networkLogger.e(error.errorMessage.toString());
      networkLogger.e(error.errorMessages.toString());
      networkLogger.e(stackTrace);

      ///check if server error
      if (error.errorType.statusCode >= 500 &&
          error.errorType.statusCode <= 599) {
        ///show technical screen
      }else if(error.errorType.statusCode == 422){
        ///handle validation error
      }

      ///check if status code is not in[401,451,422]
      ///and endpoint is not login because we show specific alert in error like block senario.
      ///to show validation dialog in app to indicate that something went wrong
      else if (error.errorType != NetworkErrorType.unauthorized &&
          error.errorType != NetworkErrorType.blocked &&
          error.errorType != NetworkErrorType.blockedMultiAccount &&
          error.errorType != NetworkErrorType.conflictData &&
          error.errorType != NetworkErrorType.unProcessable &&
          error.errorType != NetworkErrorType.badRequest ) {
        _showErrorMessage();
      } else if (error.errorType == NetworkErrorType.unauthorized) {
        ///logout and navigate to login
      }
      return BaseResponse(
          httpStatusCode: error.errorType,
          code: error.errorType.statusCode,
          message: error.errorMessage,
          success: error.success,
          errorMessages: error.errorMessages);
    } catch (error, stackTrace) {
      _showErrorMessage();
      networkLogger.e(error);
      networkLogger.e(stackTrace);
      rethrow;
    }
  }
  ///present snackbar that something wrong in api request like server error
  Future<void> _showErrorMessage() async {
    if (navigatorKey.currentState != null) {
      ///show SnackBar
    }
  }

  Future<Response<dynamic>> requestDownload(
    RouteConfig routeConfig,
  ) async {
    final headers = _setupHeaders(routeConfig);
    try {
      dynamic response = routeConfig.requestType.method == RequestType.get.method ?  await _handleDownloadGet(routeConfig, headers) : await _handleDownload(routeConfig, headers);
      return response;
    } on NetworkError catch (error, stackTrace) {
      networkLogger.e(error);
      networkLogger.e(stackTrace);
      return Response(
          requestOptions: RequestOptions(path: routeConfig.path),
          statusMessage: "$error");
    } catch (error, stackTrace) {
      networkLogger.e(error);
      networkLogger.e(stackTrace);
      rethrow;
    }
  }

  /// Appends the required headers to the request
  ///
  /// some flags sent in this method are used only inside the interceptor and removed after being used
  /// and before the request is sent
  Map<String, dynamic> _setupHeaders(RouteConfig routeConfig) {
    /// Injects Flags Into The Headers for Interceptors to handle
    final Map<String, dynamic> headers = {};
    headers.addEntries(routeConfig.headers.entries);
    return headers;
  }

  /// Handles fetching data for any [RequestType] except [RequestType.upload].
  ///
  Future<Response<dynamic>> _handleRequest(
    RouteConfig routeConfig,
    Map<String, dynamic> headers,
  ) async {
    return _dio.fetch(
      RequestOptions(
        baseUrl: routeConfig.baseUrl ?? config.baseUrl,
        method: routeConfig.requestType.method,
        path: routeConfig.path,
        queryParameters: routeConfig.parameters,
        data: routeConfig.body,
        sendTimeout: Duration(milliseconds:NetworkConst.timeout),
        receiveTimeout: Duration(milliseconds:NetworkConst.timeout),
        connectTimeout: Duration(milliseconds:NetworkConst.timeout),
        headers: headers,
        onReceiveProgress:
            routeConfig.requestProgressDelegate?.onReceiveProgress,
      ),
    );
  }

  /// Handles uploading files when [RequestType.upload]
  ///
  Future<Response<dynamic>> _handleUpload(
    RouteConfig routeConfig,
    Map<String, dynamic> headers,
  ) async {
    if (routeConfig.files != null && routeConfig.files!.isNotEmpty) {
      final List<MultipartFile> multipartFiles = [];
      for (final file in routeConfig.files!) {
        multipartFiles.add(MultipartFile.fromFileSync(file.path));
      }
      return _dio.post(
        routeConfig.fullUrl.toString(),
        data: FormData.fromMap(
          {
            routeConfig.filesArrayName ?? '': multipartFiles,
            ...routeConfig.body
          },
        ),
        onSendProgress: routeConfig.requestProgressDelegate?.onReceiveProgress,
      );
    } else {
      throw Exception('Files either null or is empty');
    }
  }

  ///download file
  Future<Response<dynamic>> _handleDownload(
    RouteConfig routeConfig,
    Map<String, dynamic> headers,
  ) async {
    dynamic response = _dio.post(
      routeConfig.path,
      options: Options(
        responseType: ResponseType.bytes,
        method: routeConfig.requestType.method,
        sendTimeout: Duration(milliseconds:NetworkConst.timeout),
        headers: headers,
      ),
      data: routeConfig.parameters,
      onSendProgress: routeConfig.requestProgressDelegate?.onReceiveProgress,
    );
    return response;
  }
  ///download file
  Future<Response<dynamic>> _handleDownloadGet(
      RouteConfig routeConfig,
      Map<String, dynamic> headers,
      ) async {
    dynamic response = _dio.get(
      routeConfig.path,
      options: Options(
        responseType: ResponseType.bytes,
        method: routeConfig.requestType.method,
        sendTimeout: Duration(milliseconds:NetworkConst.timeout),
        headers: headers,
      )
    );
    return response;
  }
}
