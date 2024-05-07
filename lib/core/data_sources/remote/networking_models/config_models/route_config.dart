import 'dart:io';
import 'package:advanced_architecture_demo/core/data_sources/remote/networking_models/config_models/request_type.dart';
import '../network_delegates/request_progress_delegate.dart';

/// Blueprint for request data
///
class RouteConfig {
  /// The base url of the end point
  String? baseUrl;
  final String path;

  /// Used only if [requestType] is [RequestType.upload] otherwise it's ignored.
  List<File>? files;

  /// Used as the key for files list in the request body
  String? filesArrayName;

  /// Required field which decides the type of the request
  final RequestType requestType;
  Map<String, String> headers;

  /// Used as query parameters
  final Map<String, dynamic> parameters;

  /// The request body ignored if [requestType] value is [RequestType.get]
  final Map<String, dynamic> body;

  final RequestProgressDelegate? requestProgressDelegate;
  final bool isTokenRequired;

  RouteConfig({
    this.baseUrl,
    required this.path,
    this.files,
    this.filesArrayName,
    required this.requestType,
    this.headers = const <String, String>{},
    this.body = const <String, dynamic>{},
    this.requestProgressDelegate,
    this.isTokenRequired = true,
    this.parameters = const {},
  });

  /// Returns full path with query
  Uri get fullUrl => Uri.parse(
        '$baseUrl/$path',
      );

  /// Returns copy of current object with any of the parameters
  RouteConfig copyWith({
    RequestType? requestType,
    String? baseUrl,
    String? path,
    List<File>? files,
    String? filesArrayName,
    Map<String, String>? headers,
    Map<String, dynamic>? parameters,
  }) =>
      RouteConfig(
        baseUrl: baseUrl ?? this.baseUrl,
        path: path ?? this.path,
        files: files ?? this.files,
        filesArrayName: filesArrayName ?? this.filesArrayName,
        requestType: requestType ?? this.requestType,
        headers: headers ?? this.headers,
        parameters: parameters ?? this.parameters,
      );
}
