// login_state.dart
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  final bool isLogin;
  final String? accessToken;
  final String? refreshToken;

  const LoginState(
      {required this.isLogin, this.accessToken, this.refreshToken});

  @override
  List<Object?> get props => [isLogin, accessToken];
}

class LoginInitial extends LoginState {
  const LoginInitial() : super(isLogin: false, accessToken: null, refreshToken: null);
}

class LoginLoading extends LoginState {
  const LoginLoading() : super(isLogin: false, accessToken: null);
}

class LoginSuccess extends LoginState {
  final String accessToken;
  final String refreshToken;

  const LoginSuccess(this.accessToken, this.refreshToken)
      : super(
            isLogin: true,
            accessToken: accessToken,
            refreshToken: refreshToken);

  @override
  List<Object?> get props => [isLogin, accessToken];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error})
      : super(isLogin: false, accessToken: null);

  @override
  List<Object?> get props => [isLogin, accessToken, error];
}
