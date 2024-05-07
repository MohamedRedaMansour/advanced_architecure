import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data_sources/local/app_secure_storage_client.dart';
import '../data_sources/local/shared_perference.dart';
import '../data_sources/remote/delegates/network_auth_imp.dart';
import '../data_sources/remote/network_manager.dart';
import '../data_sources/remote/networking_models/config_models/global_network_config.dart';
import '../environment/app_environment.dart';
import '../utils/life_cycle_app.dart';
import '../utils/tools/secure_storage.dart';
import 'injectors/injector_holder.dart';

final diInstance = GetIt.instance;

/// from any point in the widget tree or in the repos / services.
final networkManager = NetworkManager.instance;

class DependencyInjector {
  DependencyInjector({
    required this.environment,
  }) : super();

  EnvironmentType environment;

  /// injectModules that used in app-runner
  Future<void> injectModules() async {
    WidgetsFlutterBinding.ensureInitialized();

    ///configure easy loading
    customizeLoader();

    /// Loads the SharedPreferences asynchronously only once before calling runApp
    ///
    /// Eliminates the need to retrieve the sharedPrefs asynchronously everytime we
    /// retrieve data from the shared preferences
    GetIt.I.registerLazySingletonAsync<SharedPreferencesHelper>(() async =>
        SharedPreferencesHelper(
            preferences: (await SharedPreferences.getInstance())));
    await GetIt.I.getAsync<SharedPreferencesHelper>();

    _configureNetworkManger();

    /// Injects all modules in app
    InjectorHolder.injectAllApplicationModules();

    /// Register the environment type to be accessed across the app
    diInstance.registerSingleton(environment);

    final sharedHelper = diInstance<SharedPreferencesHelper>();
    WidgetsBinding.instance.addObserver(
      LifeCycleEvent(
        resumeCallBack: () async {
         ///TODO
        },
        pauseCallBack: () {
          ///TODO
        },
        detachCallBack: () {
          ///TODO
        },
      ),
    );


  }

  /// Configures network manager and it's [SecureStorageHelper]
  void _configureNetworkManger() {
    diInstance.registerSingleton<AppSecureStorageClient>(
      AppSecureStorageClient(
        storageInstance: SecureStorage(),
      ),
    );

    /// configure network manager
    networkManager.configure(
      GlobalNetworkConfig(
        baseUrl: environment.environment.baseURL,
        enableSSLPinning: true,
        auth: NetworkAuthImp(
            secureStorageClient: diInstance<AppSecureStorageClient>(),
            // authRepo: diInstance<AuthRepo>(),
            // authCubit: diInstance<AuthCubit>()
        ),
      ),
    );
  }

  void customizeLoader() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45
      ..textColor = Colors.black
      ..radius = 20
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.white
      ..indicatorColor = Colors.green
      ..userInteractions = false
      ..dismissOnTap = false
      ..boxShadow = <BoxShadow>[]
      ..indicatorType = EasyLoadingIndicatorType.threeBounce;
  }
}
