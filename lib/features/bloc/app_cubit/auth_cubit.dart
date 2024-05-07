import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repository/auth_repo.dart';
import 'auth_state.dart';


/// Handle Application Auth States. Used to set app root widget
///
/// *Available states*:
/// - [AuthorizedState] -> Registered and authenticated user, should show home
/// - [UnauthorizedState] -> User without authentication, should show login
/// - [FirstTimeAccessState] -> First time user, should show intro if any.
class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.authRepo,
  }) : super(SplashState());
  final AuthRepo authRepo;

  /// Update isFirstAccess State
  ///
  /// this updates the first access state so when the app is relaunched it doesn't show the onBoarding
  void updateFirstAccessState() {
    emit(FirstTimeAccessState());
  }

  /// Authorizes the user and emits [AuthorizedState]
  ///
  /// it can only be used by registered user either with userName & password
  void authorizeUser(
      {required String userNationalId, required String userPassword,Function? onSuccess}) {
    ///TODO
  }

  void emitUnauthorizedState() {
    emit(UnauthorizedState());
  }

  void emitRootedState() {
    emit(RootedState());
  }
  void emitBlockedLocationState() {
    emit(LocationState());
  }

  void emitVbnActiveState() {
    emit(VbnActiveState());
  }

  void emitJailbrokenState() {
    emit(JailBrokenState());
  }

  void emitNoInternetConnectionState() {
    emit(NoInternetConnectionState());
  }

  void emitForceUpdating() {
    emit(ForceUpdateState());
  }

  void emitHasMissingData() {
    emit(HasMissingDataState());
  }

  Future<void> emitUserBlockedState() async {
    await authRepo.clearSecureStorageData();
    emit(BlockedState());
  }

  Future<void> logout() async {
    await authRepo.clearSecureStorageData();
    emit(UnauthorizedState());
  }


}
