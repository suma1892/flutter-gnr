// login_state.dart
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  final bool isRegistered;

  const RegisterState({required this.isRegistered});

  @override
  List<Object?> get props => [isRegistered];
}

class CheckEmailInitial extends RegisterState {
  const CheckEmailInitial() : super(isRegistered: false);
}

class CheckEmailLoading extends RegisterState {
  const CheckEmailLoading() : super(isRegistered: false);
}

class CheckEmailSuccess extends RegisterState {
  const CheckEmailSuccess() : super(isRegistered: true);

  @override
  List<Object?> get props => [isRegistered];
}

class CheckEmailFailure extends RegisterState {
  final String error;

  const CheckEmailFailure({required this.error})
      : super(isRegistered: false);

  @override
  List<Object?> get props => [isRegistered, error];
}
