/// SecureStorage key constants
///
/// contains keys used to store and retrieve secure storage values
abstract class SecureStorageConstants {
  static const storageTokenDataKey = 'token';
  static const storageUserNationalIdDataKey = 'national_id';
  static const storageUserPasswordDataKey = 'password';
  static const passCode = 'passCode';
}

abstract class SharedPrefsConstants {
  static const onBoardingState ='onboarding_state';
  static const onHasMissingDataState = 'missingData';
  static const loginCounter = 'loginCounter';
  static const loginBlockDate ='loginBlockDate';
  static const isFirstRegister = 'isFirstRegister';
  static const sessionDuration = 'sessionDuration';
  static const isFirstTimeToShowDialog = 'firstTimeToShowDialog';
  static const enableFaceId = 'enableFaceId';
  static const appType = 'appType';
  static const countryCode = 'countryCode';
  static const email = 'email';
  static const startTime = 'startTime';
}
