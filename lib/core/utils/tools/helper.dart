import 'dart:io';

import 'package:encrypt/encrypt.dart' as ecryptor;
import 'package:advanced_architecture_demo/features/bloc/localization/localization.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screen_protector/screen_protector.dart';


import '../../../features/bloc/biometrics/biometrics_cubit.dart';
import '../../../features/ui/widgets/custom_button.dart';
import '../../../features/ui/widgets/custom_text.dart';
import '../../../main.dart';
import '../../constants/app_font_size.dart';
import '../../constants/encryption_keys.dart';
import '../../navigation/navigation.dart';
import '../../theme/colors/config_colors.dart';

class CommonHelper {
  static CommonHelper? _instance;


  CommonHelper._internal();

  factory CommonHelper() {
    return _instance ??= CommonHelper._internal();
  }


  ///Disable take the screen shoot or screen record
  static Future<void> disabledScreenShot() async {
    await ScreenProtector.preventScreenshotOn();
    ///Show toast when the user need to the take screenShot
    ScreenProtector.addListener(() {
      //CommonHelper.showNotification(Notice(message: navigatorKey.currentState!.context.localization.disableScreenShot));
    }, (p0) async{
      if(await ScreenProtector.isRecording()){
       // CommonHelper.showNotification(Notice(message: navigatorKey.currentState!.context.localization.disableScreenRecord));
      }
    });
  }

  ///Enable taken the screen shot or screen record
 static Future<void> enableScreenShot() async {
    await ScreenProtector.preventScreenshotOff();
    ScreenProtector.removeListener();
  }

  void faceIDBottomSheet(
      {required Function() onDismiss, required Function() onPressed,required bool authorizeUser}) {
    final context = navigatorKey.currentState!.context;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r), topRight: Radius.circular(8.r))),
        elevation: 0,
        isDismissible: false,
        enableDrag: false,
        builder: (context) {
          return SizedBox(
            height: 331.h,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6.h,
                    width: 65.w,
                    decoration: BoxDecoration(
                        color: ConstantsColors.secondaryColor,
                        borderRadius: BorderRadius.circular(3.r)),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      padding: EdgeInsets.only(left: 15.w, top: 15.h),
                      icon: Icon(
                        Icons.close,
                        color: ConstantsColors.grayShadeColor,
                        size: 20.w,
                      ),
                      alignment: Alignment.topLeft,
                      onPressed: () {
                        onDismiss();
                        Navigation(navigatorKey: navigatorKey).goBack();
                      },
                    ),
                  ),
                  // space(31),
                  CustomText(
                    text: context.localization.faceTitle,
                    alignment: AlignmentDirectional.center,
                    color: ConstantsColors.secondaryColor,
                    fontSize: AppFontSize.medium,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    textHeight: 1.5,
                  ),
                  SizedBox(height: 16.h,),
                  Container(
                    height: 84.h,
                    width: 84.w,
                    decoration: const BoxDecoration(
                        color: ConstantsColors.lightGreyColor,
                        shape: BoxShape.circle),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.face)
                  )),
                    SizedBox(height: 16.h,),
                  CustomText(
                    text: context.localization.faceSubTitle,
                    alignment: AlignmentDirectional.center,
                    color: ConstantsColors.grayShadeColor,
                    fontSize: AppFontSize.smallMedium,
                    textAlign: TextAlign.center,
                    maxLines: 3,
                    textHeight: 1.5,
                  ),
                  SizedBox(height: 31.h,),
                  CustomButton(
                    text: context.localization.activate,
                    onPressed: () async => onFaceIdActivated(
                        context: context,
                        onPressed: onPressed,
                        authorizeUser: authorizeUser,
                        onDismiss: onDismiss),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> onFaceIdActivated(
      {required BuildContext context,
        required bool authorizeUser,
      required Function() onPressed,
      required Function() onDismiss}) async {
    List<dynamic> list = await context.read<BiometricsCubit>().captureFaceId(authorizeUser: authorizeUser);
    bool isSuccess = list.first;
    String failureMessage = list.last;
    if (isSuccess) {
      onPressed();
      Navigation(navigatorKey: navigatorKey).goBack();
    } else if (!isSuccess) {
      if (failureMessage == "Biometry is not available.") {
        _showCustomFaceIdPermissionDialog(
            context: context, onDismiss: onDismiss);
      }
    }
  }

  void _showCustomFaceIdPermissionDialog(
      {required BuildContext context, required Function() onDismiss}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        content: const Text(
            'Biometric authentication is not enabled on your device. Please either enable Touch ID or Face ID on your phone'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () async {
              Navigator.pop(context);
              await onDismiss();
            },
            child: const Text(
              'No thanks',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: () async {
              await AppSettings.openAppSettings();
            },
            child: const Text(
              'Go to settings',
              style: TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }



  String encrypt({required String data}) {
    final key = ecryptor.Key.fromUtf8(EncryptionKeys.authKey);
    final iv = ecryptor.IV.fromUtf8(EncryptionKeys.authIv);

    final encryption = ecryptor.Encrypter(
        ecryptor.AES(key, mode: ecryptor.AESMode.cbc, padding: 'PKCS7'));

    final encrypted = encryption.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  String decrypt({required String data}) {
    final key = ecryptor.Key.fromUtf8(EncryptionKeys.authKey);
    final iv = ecryptor.IV.fromUtf8(EncryptionKeys.authIv);
    final encryption = ecryptor.Encrypter(
        ecryptor.AES(key, mode: ecryptor.AESMode.cbc, padding: 'PKCS7'));

    final decrypted = encryption.decrypt64(data, iv: iv);
    return decrypted;
  }
  ///check internet connection
  Future<bool> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

}
