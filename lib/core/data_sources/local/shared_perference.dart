import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/storage_keys.dart';

class SharedPreferencesHelper {
  SharedPreferencesHelper({required this.preferences});

  final SharedPreferences preferences;

  /// Saves the onBoarding state so the user is only presented with onBoarding screen once
  Future<bool> saveOnBoardingState(String token) async {
    return await preferences.setString(
        SharedPrefsConstants.onBoardingState, token);
  }

  /// fetching OnBoardingState from shared preferences
  Future<String?> getOnBoardingState() async {
    return preferences.getString(SharedPrefsConstants.onBoardingState);
  }


  Future<bool> clearHasMissingDataState() async {
    return await preferences.remove(SharedPrefsConstants.onHasMissingDataState);
  }

  /// Saves how many user try to login
  Future<bool> saveLoginTries({required int counter}) async {
    return await preferences.setInt(SharedPrefsConstants.loginCounter, counter);
  }

  /// get how many user try to login
  Future<int?> getLoginTries() async {
    return preferences.getInt(SharedPrefsConstants.loginCounter);
  }

  ///clear login tries counter
  Future<bool> clearLoginTries() async {
    return await preferences.remove(SharedPrefsConstants.loginCounter);
  }

  /// Saves the onBoarding state so the user is only presented with onBoarding screen once
  Future<bool> saveLoginBlockDate({required String date}) async {
    return await preferences.setString(
        SharedPrefsConstants.loginBlockDate, date);
  }

  ///clear Login Block Date
  Future<bool> clearLoginBlockDate() async {
    return await preferences.remove(SharedPrefsConstants.loginBlockDate);
  }

  /// fetching OnBoardingState from shared preferences
  Future<String?> getLoginBlockDate() async {
    return preferences.getString(SharedPrefsConstants.loginBlockDate);
  }

  ///clear All data except onBoarding state because in logout we haven't to clear onBoarding state.
  ///OnBoardingState only relates to first time open
  Future<void> clearData() async {
    String? onBoardingState = await getOnBoardingState();
    await preferences.clear();
    if (onBoardingState != null) {
      saveOnBoardingState(onBoardingState);
    }
  }

  /// get if user has just register or not
  Future<bool?> getFirstRegister() async {
    return preferences.getBool(SharedPrefsConstants.isFirstRegister);
  }

  Future<bool?> setFirstRegister(bool data) async {
    return await preferences.setBool(
        SharedPrefsConstants.isFirstRegister, data);
  }

  ///show update contract dialog
  Future<bool?> getDialogStatus() async {
    return preferences.getBool(SharedPrefsConstants.isFirstTimeToShowDialog);
  }

  Future<bool?> setDialogStatus(bool data) async {
    return await preferences.setBool(
        SharedPrefsConstants.isFirstTimeToShowDialog, data);
  }

  /// Saves session duration
  Future<bool> saveSessionDuration({required String date}) async {
    return await preferences.setString(
        SharedPrefsConstants.sessionDuration, date);
  }

  ///clear session duration
  Future<bool> clearSessionDuration() async {
    return await preferences.remove(SharedPrefsConstants.sessionDuration);
  }

  /// fetching session duration
  Future<String?> getSessionDuration() async {
    return preferences.getString(SharedPrefsConstants.sessionDuration);
  }

  /// get if user enable or disable faceId option
  Future<bool?> getFaceIdValue() async {
    return preferences.getBool(SharedPrefsConstants.enableFaceId);
  }

  Future<bool> saveFaceIdValue({required bool value}) async {
    return await preferences.setBool(SharedPrefsConstants.enableFaceId, value);
  }


  Future<bool> saveCountryCode({required String countryCode}) async {
    log("countryCode $countryCode saved!!");
    return await preferences.setString(
        SharedPrefsConstants.countryCode, countryCode);
  }

  Future<String> getCountryCode() async {
    return preferences.getString(SharedPrefsConstants.countryCode) ?? "SA";
  }

  ///save email value
  String? getEmailValue() {
    return preferences.getString(SharedPrefsConstants.email);
  }
  Future<bool> saveEmailValue({required String email}) async {
    return await preferences.setString(
        SharedPrefsConstants.email, email);
  }
  Future<bool> clearEmailValue() async {
    return await preferences.remove(
        SharedPrefsConstants.email);
  }

  Future<bool> storeCurrentTimeStamp() async {
    var time=await preferences.setString(SharedPrefsConstants.startTime, DateTime.now().toString());
    return time;
  }
  DateTime getCurrentTimeStamp() {
    DateTime result= DateTime.parse(preferences.getString(SharedPrefsConstants.startTime)?? "${DateTime.now()}");
    return result;
  }
  Future<bool> removeCurrentTimeStamp() async {
    return await preferences.remove(SharedPrefsConstants.startTime);
  }
}
