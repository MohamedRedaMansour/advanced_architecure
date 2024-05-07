/// contains any network error associated with its [statusCode]
enum NetworkErrorType {
  badRequest(400),
  unauthorized(401),
  forbidden(403),
  notFound(404),
  conflict(409),
  internalServerError(500),
  noInternetConnection(900),
  responseExposed(901),
  unProcessable(422),
  blocked(451),
  blockedMultiAccount(452),
  conflictData(408),
  tooManyRequest(429),
  maintenance(503);
  /// Http Status code
  final int statusCode;
  const NetworkErrorType(this.statusCode);

  /// Maps status code to [NetworkErrorType]
  ///
  /// there's special status codes used to map to special error types (non-http) errors
  /// 900 => [noInternetConnection]
  /// 901 => [responseExposed]
  static NetworkErrorType getType(int code) {
    switch (code) {
      case 400:
        return NetworkErrorType.badRequest;
      case 401:
        return NetworkErrorType.unauthorized;
      case 403:
        return NetworkErrorType.forbidden;
      case 404:
        return NetworkErrorType.notFound;
      case 500:
        return NetworkErrorType.internalServerError;
      case 503:
        return NetworkErrorType.internalServerError;
      case 901:
        return NetworkErrorType.responseExposed;
      case 422:
        return NetworkErrorType.unProcessable;
      case 451:
        return NetworkErrorType.blocked;
      case 452:
        return NetworkErrorType.blockedMultiAccount;
      case 408:
        return NetworkErrorType.conflictData;
      case 429:
        return NetworkErrorType.tooManyRequest;
      default:
        return NetworkErrorType.noInternetConnection;
    }
  }
}
