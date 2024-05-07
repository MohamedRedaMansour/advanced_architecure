
import '../../local/app_secure_storage_client.dart';
import '../networking_models/network_delegates/network_auth_delegate.dart';

class NetworkAuthImp extends NetworkAuthDelegate {
  NetworkAuthImp({
    required this.secureStorageClient,

  });

  final AppSecureStorageClient secureStorageClient;

  @override
  Future<String> getToken() async {
    return (await secureStorageClient.getUserToken()) ?? '';
  }

  // @override
  // Future<String?> refreshToken() async {
  //   return authRepo.refreshToken();
  // }

  @override
  Future<void> onRefreshFail() async{
    //logout then navigate to login
  }
   @override
  Future<void> removeToken() async{
    // Delete value
     return (await secureStorageClient.removeToken());
  }
}
