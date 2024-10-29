// login_state.dart
import 'package:equatable/equatable.dart';

abstract class CheckEmailState extends Equatable {
  final bool isRegistered;

  const CheckEmailState({required this.isRegistered});

  @override
  List<Object?> get props => [isRegistered];
}

class CheckEmailInitial extends CheckEmailState {
  const CheckEmailInitial() : super(isRegistered: false);
}

class CheckEmailLoading extends CheckEmailState {
  const CheckEmailLoading() : super(isRegistered: false);
}

class CheckEmailSuccess extends CheckEmailState {
  const CheckEmailSuccess() : super(isRegistered: true);

  @override
  List<Object?> get props => [isRegistered];
}

class CheckEmailFailure extends CheckEmailState {
  final String error;

  const CheckEmailFailure({required this.error})
      : super(isRegistered: false);

  @override
  List<Object?> get props => [isRegistered, error];
}
