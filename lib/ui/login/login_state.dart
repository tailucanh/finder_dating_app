part of 'login_cubit.dart';

class LoginState extends Equatable {
  final LoadStatus loadDataStatus;
  final GoogleSignInAccount? authentication;

  const LoginState(
      {this.loadDataStatus = LoadStatus.initial, this.authentication});

  @override
  List<Object?> get props => [loadDataStatus, authentication];

  LoginState copyWith(
      {LoadStatus? loadDataStatus, GoogleSignInAccount? authentication}) {
    return LoginState(
        loadDataStatus: loadDataStatus ?? this.loadDataStatus,
        authentication: authentication ?? this.authentication);
  }
}
