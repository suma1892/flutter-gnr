import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String fullname;
  final String email;
  final String password;
  final String passwordConfirmation;

  RegisterSubmitted(
      {required this.fullname,
      required this.email,
      required this.password,
      required this.passwordConfirmation});

  @override
  List<Object> get props => [fullname, email, password, passwordConfirmation];
}
