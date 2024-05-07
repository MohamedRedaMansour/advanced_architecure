
import '../network_delegates/index.dart';

/// Wraps the global networking configuration properties
class GlobalNetworkConfig {
  /// The global base url
   String baseUrl;

  /// Enables SSL pinning when value is `true` [certificatePath] must also have a value
  final bool enableSSLPinning;

  /// TODO: Enables caching responses
  final bool enableCachingInterceptor;

  /// Handler for [NetworkAuthDelegate] events like [auth.refreshToken()] etc.
  final NetworkAuthDelegate? auth;

  /// The path of the SSL certificate used in SSL Pinning
  ///
  /// ignored if [enableSSLPinning] value is `false`
  final String? certificatePath;

  GlobalNetworkConfig(
      {this.baseUrl = '',
      this.enableSSLPinning = false,
      this.enableCachingInterceptor = false,
      this.certificatePath,
      this.auth});
}
