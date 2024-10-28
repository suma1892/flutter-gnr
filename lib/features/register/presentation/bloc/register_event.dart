import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterSubmitted extends RegisterEvent {
  final String email;

  RegisterSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}
