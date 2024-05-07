

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create storage

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final IOSOptions _iosOptions = const IOSOptions();
  final AndroidOptions _androidOptions = const AndroidOptions(
    encryptedSharedPreferences: true,
  );

  /// removing data from secure storage
  removeValue(String key) async {
    return await _storage.delete(key: key);
  }

  ///saving data to secure storage
  Future<void> write({
    required String key,
    required String? value,
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async {
    await _storage.write(
      key: key,
      value: value,
      iOptions: iosOptions ?? _iosOptions,
      aOptions: androidOptions ?? _androidOptions,
    );
  }

  /// fetching data from secure storage
  Future<String?> read({
    required String key,
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async {
    return await _storage.read(
      key: key,
      iOptions: iosOptions ?? _iosOptions,
      aOptions: androidOptions ?? _androidOptions,
    );
  }

  /// Deletes all data in the secure storage
  Future<void> deleteAll({
    IOSOptions? iosOptions,
    AndroidOptions? androidOptions,
  }) async {
    await _storage.deleteAll(
      iOptions: iosOptions ?? _iosOptions,
      aOptions: androidOptions ?? _androidOptions,
    );
  }
}
