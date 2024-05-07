

import '../../../../features/repository/auth_repo.dart';
import '../../../data_sources/local/app_secure_storage_client.dart';
import '../../../data_sources/local/shared_perference.dart';
import '../../dependency_injector.dart';
import '../base_injector.dart';

/// [ReposInjector] hold all application repos dependencies
class ReposInjector extends BaseInjector {
  static final reposInjectors = [
        () => diInstance.registerLazySingleton<AuthRepo>(
          () => AuthRepoImp(
        networkManager: networkManager,
        secureStorageClient: diInstance<AppSecureStorageClient>(),
        sharedPreferencesHelper: diInstance<SharedPreferencesHelper>(),
      ),
    ),
  ];
  /// iterate and inject all repos
  @override
  void injectModules() {
    for (final repoInjector in reposInjectors) {
      repoInjector.call();
    }
  }
}
