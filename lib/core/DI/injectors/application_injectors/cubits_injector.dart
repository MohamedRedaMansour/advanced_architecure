import 'package:advanced_architecture_demo/core/data_sources/local/app_secure_storage_client.dart';
import 'package:advanced_architecture_demo/features/bloc/app_cubit/auth_cubit.dart';
import 'package:advanced_architecture_demo/features/bloc/biometrics/biometrics_cubit.dart';
import 'package:advanced_architecture_demo/features/bloc/splash/splash_cubit.dart';

import '../../../../features/bloc/localization/localization_cubit.dart';
import '../../../../features/repository/auth_repo.dart';
import '../../../data_sources/local/shared_perference.dart';
import '../../dependency_injector.dart';
import '../base_injector.dart';


/// [CubitsInjector] hold all application cubits dependencies
///
/// global cubits are injected here not the APIs cubits, other cubits are used via blocProviders
class CubitsInjector extends BaseInjector {
  static final cubitsInjectors = [
    () => diInstance.registerLazySingleton<LocalizationCubit>(
          () => LocalizationCubit(
            sharedPrefsClient: diInstance<SharedPreferencesHelper>(),
          ),
        ),
        () => diInstance.registerLazySingleton<SplashCubit>(
          () => SplashCubit(
            sharedPreferencesHelper: diInstance<SharedPreferencesHelper>(),
            appSecureStorageClient: diInstance<AppSecureStorageClient>(),
            authCubit: diInstance<AuthCubit>(),
            biometricsCubit: diInstance<BiometricsCubit>(),
      ),
    ),
        () => diInstance.registerLazySingleton<AuthCubit>(
          () => AuthCubit(
        authRepo: diInstance<AuthRepo>(),
      ),
    ),
        () => diInstance.registerLazySingleton<BiometricsCubit>(
          () => BiometricsCubit(
        appSecureStorageClient: diInstance<AppSecureStorageClient>(),
        authCubit: diInstance<AuthCubit>(),
      ),
    ),
  ];

  @override
  void injectModules() {
    for (final cubitInjector in cubitsInjectors) {
      cubitInjector.call();
    }
  }
}
