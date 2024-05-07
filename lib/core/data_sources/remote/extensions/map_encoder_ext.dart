import 'dart:convert';

import 'package:dio/dio.dart';

/// Adds [toJson] method to encode Map to json String
extension MapEncoderExt on Map {
  /// Encode Map response object to json string
  String toJson() {
    return jsonEncode(this);
  }

}
