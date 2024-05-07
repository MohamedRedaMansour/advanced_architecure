import 'package:advanced_architecture_demo/features/repository/auth_repo.dart';
import 'package:provider/single_child_widget.dart' as blocSrc;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../features/bloc/app_cubit/auth_cubit.dart';
import '../../../features/bloc/biometrics/biometrics_cubit.dart';
import '../../../features/bloc/localization/localization_cubit.dart';
import '../../../features/bloc/splash/splash_cubit.dart';
import '../../DI/dependency_injector.dart';
import '../../data_sources/local/app_secure_storage_client.dart';
import '../../data_sources/local/shared_perference.dart';


//[CubitProvidersList] contains all main cubits providers of app
class CubitProvidersList {
  static final List<blocSrc.SingleChildWidget> providerList = [
    BlocProvider(create: (_) => GetIt.I<LocalizationCubit>()),
    BlocProvider<BiometricsCubit>(
      create: (context) => BiometricsCubit(
         appSecureStorageClient: GetIt.I<AppSecureStorageClient>(),
         authCubit: GetIt.I<AuthCubit>(),
      ),
    ),
    BlocProvider<SplashCubit>(
      create: (context) => SplashCubit(
        appSecureStorageClient: diInstance<AppSecureStorageClient>(),
        authCubit: diInstance<AuthCubit>(),
        biometricsCubit: diInstance<BiometricsCubit>(),
        sharedPreferencesHelper: diInstance<SharedPreferencesHelper>(),
      ),
    ),
    BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(
        authRepo: diInstance<AuthRepo>()
      ),
    ),
  ];
}
