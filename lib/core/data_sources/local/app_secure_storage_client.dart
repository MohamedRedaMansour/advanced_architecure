import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../constants/storage_keys.dart';
import '../../utils/tools/secure_storage.dart';

/// Provides methods to store and retrieve specific data to the SecureStorage
///
///
class AppSecureStorageClient {
  final SecureStorage storageInstance;

  AppSecureStorageClient({required this.storageInstance});

  ///saving token to secure storage
  Future<void> saveUserToken({ String? token}) async {
    await storageInstance.write(
      key: SecureStorageConstants.storageTokenDataKey,
      value: token,
      iosOptions: const IOSOptions(accountName: 'token1',)
    );
  }

  /// fetching user token from secure storage
  Future<String?> getUserToken() async {
    String? token = await storageInstance.read(key: SecureStorageConstants.storageTokenDataKey, iosOptions: IOSOptions(accountName: 'token1'));
    return token;
  }
  /// fetching remove user storage
  Future<void> removeToken( ) async {
     await storageInstance.removeValue(SecureStorageConstants.storageTokenDataKey);
  }
  ///saving UserNationalId to secure storage
  Future<void> saveUserNationalId({ String? id}) async {
    await storageInstance.write(
      key: SecureStorageConstants.storageUserNationalIdDataKey,
      value: id,
    );
  }

  /// fetching user UserNationalId from secure storage
  Future<String?> getUserNationalId() async {
    String? id = await storageInstance.read(key: SecureStorageConstants.storageUserNationalIdDataKey);
    return id;
  }

  ///saving UserPassword to secure storage
  Future<void> saveUserPassword({ String? password}) async {
    await storageInstance.write(
      key: SecureStorageConstants.storageUserPasswordDataKey,
      value: password,
    );
  }

  /// fetching user UserPassword from secure storage
  Future<String?> getUserPassword() async {
    String? password = await storageInstance.read(key: SecureStorageConstants.storageUserPasswordDataKey);
    return password;
  }

  ///saving passCode to secure storage
  Future<void> savePassCode({ String? passCode}) async {
    await storageInstance.write(
      key: SecureStorageConstants.passCode,
      value: passCode,
    );
  }
  /// fetching pass code from secure storage
  Future<String?> getPassCode() async {
    String? passCode = await storageInstance.read(key: SecureStorageConstants.passCode);
    return passCode;
  }

 Future<void> clearAllData() async {
   await storageInstance.deleteAll();
  }
}
