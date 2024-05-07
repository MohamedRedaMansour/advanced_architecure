import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/data_sources/local/app_secure_storage_client.dart';
import '../../../main.dart';
import '../app_cubit/auth_cubit.dart';


class BiometricsCubit extends Cubit<void> {
   final AuthCubit authCubit;
   final AppSecureStorageClient appSecureStorageClient;
  BiometricsCubit(
      { required this.appSecureStorageClient,required this.authCubit})
      : super(null);
  final LocalAuthentication auth = LocalAuthentication();
  final context = navigatorKey.currentState!.context;

  Future<bool> canAuthenticateWithBiometrics() async {
    final bool isSupported = await checkBiometricsSupport();
    return isSupported;
  }

  Future<bool> hasFaceId() async {
    final bool canAuthenticate = await canAuthenticateWithBiometrics();
    if (canAuthenticate) {
      List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      bool isFaceTypeInAndroid = (Platform.isAndroid &&
          (availableBiometrics.contains(BiometricType.weak) ||
              availableBiometrics.contains(BiometricType.face)));
      bool isFaceTypeInIos = availableBiometrics.contains(BiometricType.face);
      if (availableBiometrics.isNotEmpty &&
          (isFaceTypeInIos || isFaceTypeInAndroid)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkBiometricsSupport() async {
    const platform = MethodChannel('face_id_channel');
    try {
      final bool res = await platform.invokeMethod('checkFaceIDSupport');
      return res;
    } on PlatformException catch (e) {
      return false;
    }
  }

  Future<List<dynamic>> captureFaceId({bool isLogin = false,required bool authorizeUser}) async {
    //try {
    //   final bool didAuthenticate = await auth.authenticate(
    //       localizedReason: 'Please authenticate to log in',
    //       options: const AuthenticationOptions(biometricOnly: true),
    //       authMessages: const <AuthMessages>[
    //         AndroidAuthMessages(
    //           signInTitle: 'Oops! Biometric authentication required!',
    //           cancelButton: 'No thanks',
    //         ),
    //         IOSAuthMessages(
    //           cancelButton: 'No thanks',
    //         ),
    //       ]);
    //   if(authorizeUser == true) {
    //     if (didAuthenticate && isLogin == false) {
    //       emitAuthorizedState(onSuccess: () {
    //         FocusManager.instance.primaryFocus?.unfocus();
    //         context.showNotice(Notice(
    //           message: context.localization.paymentSuccessTitle,
    //         ));
    //       });
    //       return [true, ''];
    //     } else if (didAuthenticate && isLogin == true) {
    //       emitAuthorizedState(onSuccess: () {});
    //       return [true, ''];
    //     }
    //   }
    //   return [true, ''];
    //   // ···
    // } on PlatformException catch (e) {
    //   if (e.message == "Biometry is not available.") {
    //     return [false, e.message];
    //     // TODO waiting for message from bussiness
    //   }
    //   if (e.code == auth_error.notEnrolled) {
    //     // TODO waiting for message from bussiness
    //   }
    //   if (e.code == auth_error.lockedOut ||
    //       e.code == auth_error.permanentlyLockedOut) {
    //     // TODO waiting for message from bussiness
    //   }
    //   {
    //     // TODO waiting for message from bussiness
    //   }
    //   Navigation(navigatorKey: navigatorKey).navigateTo(
    //       routeName: RoutesNames.passCodeScreen,
    //       arg: PassCodeArguments(
    //           type: PassCodePageType.login.type,
    //           onSuccess: () {
    //             emitAuthorizedState(onSuccess: () {});
    //           }));
      return [false, ''];
    //}
  }

  void emitAuthorizedState({Function? onSuccess}) async {
    String? userNationalId = await appSecureStorageClient.getUserNationalId();
    String? userPassword = await appSecureStorageClient.getUserPassword();
    authCubit.authorizeUser(
        userNationalId: userNationalId ?? '',
        userPassword: userPassword ?? '',
        onSuccess: onSuccess);
   }
}
