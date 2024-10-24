import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class TokenRefreshed extends LoginEvent {
  final String newAccessToken;
  final String newRefreshToken;

  TokenRefreshed({required this.newAccessToken, required this.newRefreshToken});
}
