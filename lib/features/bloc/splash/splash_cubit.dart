import 'package:advanced_architecture_demo/features/bloc/app_cubit/auth_cubit.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:flutter/foundation.dart';

import '../../../core/data_sources/local/app_secure_storage_client.dart';
import '../../../core/data_sources/local/shared_perference.dart';
import '../../../core/utils/root_jailbreak_detector.dart';
import '../../../core/utils/tools/helper.dart';
import '../app_cubit/base_app_cubit.dart';
import '../biometrics/biometrics_cubit.dart';

/// [SplashCubit] to get date before main screen then route
class SplashCubit extends BaseAppCubit<void> {
  SplashCubit({required this.authCubit,
    required this.appSecureStorageClient,
    required this.sharedPreferencesHelper,
    required this.biometricsCubit
  });

  final AppSecureStorageClient appSecureStorageClient;
  final SharedPreferencesHelper sharedPreferencesHelper;
  final AuthCubit authCubit;

  final BiometricsCubit biometricsCubit;


  /// Emits initial [AuthState] to navigate user from splash page to corresponding
  /// page based on the emitted state.
  ///
  /// - [RootedState] & [JailBrokenState] => emitted when the user access the app
  /// from jailbroken / rooted device and exit user from app
  /// - [FirstTimeAccessState] => emitted when the user access the app for the
  /// first time and navigate to OnboardingPage.
  /// - [AuthorizedState] => emitted when the user is already signed before
  /// and navigates user to the home page directly (Autologin).
  /// - [UnauthorizedState] => emitted when the user is not logged in or not
  /// the first time to open the app and navigate user to the Login Page.
  Future<void> emitInitialAuthState() async {
    bool isFirstTimeAccess =
        (await sharedPreferencesHelper.getOnBoardingState()) == null;

    ///check if user signed before
    bool isUserAlreadySigned = false;
    String? passCode;
    final bool hasFaceId;

    ///[isUserHasPasscode] : To check if user has passCode or not
    bool isUserHasPasscode = false;

    ///[isUserHasFaceId] : To check if user has faceId or not
    bool isUserHasFaceId = false;


    ///check if no internet connection
    if (await CommonHelper().checkInternetConnectivity() == false) {
      return emitNoInternetConnectionState();
    }

    bool mustForcingUpdate = false;



    await Future.delayed(const Duration(seconds: 2));

    if (!kDebugMode) {
      // ordering sequence is important 1) Jailbreak , 2) VPN , 3)location SA
      if (await RootJailBreakDetector.isDeviceRooted()) {
        return emitRootedState();
      }
      if (await RootJailBreakDetector.isDeviceJailBroken()) {
        return emitJailbrokenState();
      }
      if (await CheckVpnConnection.isVpnActive()) {
        return emitVbnActiveState();
      }

    }


    if (isFirstTimeAccess) return emitFirstAccessState();


    if(isUserAlreadySigned == true && isUserHasPasscode == false && isUserHasFaceId == true){
      return emitUnauthorizedState();
    }



    emitUnauthorizedState();
  }

  void emitFirstAccessState() {
    authCubit.updateFirstAccessState();
  }

  void emitForceUpdating() {
    authCubit.emitForceUpdating();
  }

  void emitBlockingState() {
    authCubit.emitUserBlockedState();
  }

  void emitUnauthorizedState() {
    authCubit.emitUnauthorizedState();
  }

  void emitAuthorizedState({required String userPassword , required String userNationalId}){
    authCubit.authorizeUser(
      userNationalId: userNationalId ,
      userPassword: userPassword ,
    );
  }

  void emitRootedState() {
    authCubit.emitRootedState();
  }

  void emitBlockedLocationState() {
    authCubit.emitBlockedLocationState();
  }

  void emitVbnActiveState() {
    authCubit.emitVbnActiveState();
  }

  void emitJailbrokenState() {
    authCubit.emitJailbrokenState();
  }

  void emitNoInternetConnectionState() {
    authCubit.emitNoInternetConnectionState();
  }
}