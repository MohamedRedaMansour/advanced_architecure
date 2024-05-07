

/// Wraps callback to receive sent request progress
class RequestProgressDelegate {
  /// Callback invoked when request progress is updated
  ///
  /// [count] is the length of the bytes that have been sent/received.
  ///
  /// [total] is the content length of the response/request body.
  /// 1.When receiving data:
  ///   [total] is the request body length.
  /// 2.When receiving data:
  ///   [total] will be -1 if the size of the response body is not known in advance,
  ///   for example: response data is compressed with gzip or no content-length header.
  void Function(int count, int total)? onReceiveProgress;

  RequestProgressDelegate({this.onReceiveProgress});
}
