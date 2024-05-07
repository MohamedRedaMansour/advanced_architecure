import 'dart:async';

import '../../core/data_sources/local/app_secure_storage_client.dart';
import '../../core/data_sources/local/shared_perference.dart';
import '../../core/data_sources/remote/network_manager.dart';


/// [AuthRepo] hold abstraction for authorization
abstract class AuthRepo {

  Future<bool?>getFirstRegister();

  Future<bool> clearHasMissingDataState();

  Future<void> clearSecureStorageData();

  ///save how many user try to login
  Future<void> saveLoginTriesCounter({required int counter});

  Future<int?> getLoginTries();

  Future<void> clearLoginTries();

  Future<void> saveLoginBlockDate({required String date});

  Future<void> clearLoginBlockDate();

  Future<String?> getLoginBlockDate();
  ///save session duration
  Future<void> saveSessionDuration({required String date});

  Future<void> clearSessionDuration();

  Future<String?> getSessionDurationDate();

  Future<String?> getPassCode();

  Future<void> savePassCode({required String passCode});
}

/// [AuthRepoImp] hold logic for authorization
class AuthRepoImp implements AuthRepo {
  final NetworkManager networkManager;
  final AppSecureStorageClient secureStorageClient;
  final SharedPreferencesHelper sharedPreferencesHelper;

  AuthRepoImp(
      {required this.networkManager,
      required this.secureStorageClient,
      required this.sharedPreferencesHelper});



  @override
  Future<bool?> getFirstRegister()async{
   return  await sharedPreferencesHelper.getFirstRegister();
  }

  @override
  Future<bool> clearHasMissingDataState() async {
    return await sharedPreferencesHelper.clearHasMissingDataState();
  }


  @override
  Future<void> saveLoginTriesCounter({required int counter}) async {
    await sharedPreferencesHelper.saveLoginTries(counter: counter);
  }

  Future<int?> getLoginTries() async {
    int? counter = await sharedPreferencesHelper.getLoginTries();
    return counter;
  }

  Future<void> clearLoginTries() async {
    await sharedPreferencesHelper.clearLoginTries();
  }

  Future<void> saveLoginBlockDate({required String date}) async {
    await sharedPreferencesHelper.saveLoginBlockDate(date: date);
  }

  Future<void> clearLoginBlockDate() async {
    await sharedPreferencesHelper.clearLoginBlockDate();
  }

  Future<String?> getLoginBlockDate() async {
    String? date = await sharedPreferencesHelper.getLoginBlockDate();
    return date;
  }

  @override
  Future<void> clearSecureStorageData() async {
    await secureStorageClient.clearAllData();
    await sharedPreferencesHelper.clearData();
  }

  @override
  Future<void> clearSessionDuration() async {
    await sharedPreferencesHelper.clearSessionDuration();
  }

  @override
  Future<void> saveSessionDuration({required String date}) async {
    await sharedPreferencesHelper.saveSessionDuration(date: date);
  }
  Future<String?> getSessionDurationDate() async {
    String? date = await sharedPreferencesHelper.getSessionDuration();
    return date;
  }

  @override
  Future<String?> getPassCode() async {
    String? passCode = await secureStorageClient.getPassCode();
    return passCode;
  }

  @override
  Future<void> savePassCode({required String passCode}) async {
    await secureStorageClient.savePassCode(passCode: passCode);
  }
}
