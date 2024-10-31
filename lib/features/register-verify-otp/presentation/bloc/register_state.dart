import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  final String session;

  const RegisterState({required this.session});

  @override
  List<Object?> get props => [session];
}

class RegisterInitial extends RegisterState {
  const RegisterInitial() : super(session: '');
}

class RegisterLoading extends RegisterState {
  const RegisterLoading() : super(session: '');
}

class RegisterSuccess extends RegisterState {
  final String session;

  const RegisterSuccess(this.session) : super(session: session);

  @override
  List<Object?> get props => [session];
}

class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error})
      : super(session: '');

  @override
  List<Object?> get props => [session, error];
}
