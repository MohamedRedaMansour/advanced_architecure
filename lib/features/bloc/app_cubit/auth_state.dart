/// Auth State
abstract class AuthState {
  const AuthState();
}

/// Splash State which performs the splash screen operations
class SplashState extends AuthState {}

/// Rooted State
class RootedState extends AuthState {}

/// Rooted State
class VbnActiveState extends AuthState {}

/// location State
class LocationState extends AuthState {}

/// JailBroken State
class JailBrokenState extends AuthState {}

/// JailBroken State
class NoInternetConnectionState extends AuthState {}

/// Update App State
class UpdateAppAccessState extends AuthState {}

/// First Time User
///
/// This preloads the onBoarding data and preloads the images
class FirstTimeAccessState extends AuthState {}

/// Force update app State
class ForceUpdateState extends AuthState {}
/// has missing data app State
class HasMissingDataState extends AuthState {}

class BlockedState extends AuthState {}

/// Logged-In & Authorized User State. Holds a token.
class AuthorizedState extends AuthState {
  final int tapIndex;
  AuthorizedState({this.tapIndex = 0});
}

/// Unauthorized State
class UnauthorizedState extends AuthState {
  UnauthorizedState();
}
