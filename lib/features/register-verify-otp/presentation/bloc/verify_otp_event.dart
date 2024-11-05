import 'package:equatable/equatable.dart';

abstract class VerifyOtpEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class VerifyOtpSubmitted extends VerifyOtpEvent {
  final String session;
  final String token;

  VerifyOtpSubmitted(
      {required this.session,
      required this.token});

  @override
  List<Object> get props => [session, token];
}
