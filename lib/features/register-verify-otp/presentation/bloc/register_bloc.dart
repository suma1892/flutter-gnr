import 'dart:developer' as developer;
import 'package:flutter_get_ride_app/core/network/dio_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends HydratedBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(RegisterLoading());

      try {
        var client = DioClient();
        final response =
            await client.dio.post('/authorization/register', data: {
          'fullname': event.fullname,
          'email': event.email,
          'password': event.password,
          'password_confirmation': event.passwordConfirmation,
          'registration_type': 'email',
        });
        developer.log('Response Data: ${response.data}');

        if (response.statusCode == 200) {
          developer.log('masuk 200');
          final responseData = response.data;
          emit(RegisterSuccess(responseData['session']));
        } else {
          emit(RegisterFailure(error: 'Server error: ${response.statusCode}'));
        }
      } catch (e) {
        developer.log('error: ${e.toString()}');
        emit(RegisterFailure(error: e.toString()));
      }
    });
  }

  @override
  RegisterState? fromJson(Map<String, dynamic> json) {
    try {
      final session = json['session'] as String;
      return session.isNotEmpty ? RegisterSuccess(session) : RegisterInitial();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(RegisterState state) {
    return {
      'session': state.session,
    };
  }
}
