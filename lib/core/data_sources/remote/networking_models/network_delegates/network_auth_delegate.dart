/// Wraps the required callbacks to handle authentication related issues
///
abstract class NetworkAuthDelegate {
  /// Returns the authentication token string asynchronously
  Future<String> getToken();

   /// remove token asynchronously
  Future<void> removeToken();

  /// Refresh the authentication token and returns String otherwise if failed to refresh returns null
  // Future<String?> refreshToken();

  /// Invoked when the refreshToken failed to refresh the token and throws
  /// 401 unauthorized error.
  Future<void> onRefreshFail();
}
