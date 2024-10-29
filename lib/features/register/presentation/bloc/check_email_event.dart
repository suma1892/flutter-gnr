import 'package:equatable/equatable.dart';

abstract class CheckEmailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckEmailSubmitted extends CheckEmailEvent {
  final String email;

  CheckEmailSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}
