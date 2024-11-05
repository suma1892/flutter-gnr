import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  final bool isLogin;
  final String? accessToken;
  final String? refreshToken;

  const VerifyOtpState(
      {required this.isLogin, this.accessToken, this.refreshToken});

  @override
  List<Object?> get props => [isLogin, accessToken];
}

class VerifyOtpInitial extends VerifyOtpState {
  const VerifyOtpInitial() : super(isLogin: false, accessToken: null, refreshToken: null);
}

class VerifyOtpLoading extends VerifyOtpState {
  const VerifyOtpLoading() : super(isLogin: false, accessToken: null);
}

class VerifyOtpSuccess extends VerifyOtpState {
  final String accessToken;
  final String refreshToken;

  const VerifyOtpSuccess(this.accessToken, this.refreshToken)
      : super(
            isLogin: true,
            accessToken: accessToken,
            refreshToken: refreshToken);

  @override
  List<Object?> get props => [isLogin, accessToken];
}

class VerifyOtpFailure extends VerifyOtpState {
  final String error;

  const VerifyOtpFailure({required this.error})
      : super(isLogin: false, accessToken: null);

  @override
  List<Object?> get props => [isLogin, accessToken, error];
}
