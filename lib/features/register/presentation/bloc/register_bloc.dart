import 'dart:developer' as developer;
import 'package:flutter_get_ride_app/core/network/dio_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends HydratedBloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(CheckEmailInitial()) {
    on<RegisterSubmitted>((event, emit) async {
      emit(CheckEmailLoading());

      try {
        var client = DioClient();
        final response =
            await client.dio.post('/authorization/checkemail', data: {
          'email': event.email,
        });
        developer.log('Response Data: ${response.data}');

        if (response.statusCode == 200) {
          developer.log('masuk 200 ');
          final responseData = response.data;
          final isRegistered = responseData['is_register'];

          if (!isRegistered) {
            emit(CheckEmailSuccess());            
          } else {
            emit(CheckEmailFailure(error: 'Email sudah terdaftar'));
          }
        } else {
          emit(CheckEmailFailure(error: 'Server error: ${response.statusCode}'));
        }
      } catch (e) {
        developer.log(e.toString());
        emit(CheckEmailFailure(error: e.toString()));
      }
    });
  }

  @override
  RegisterState? fromJson(Map<String, dynamic> json) {
    try {
      final isRegistered = json['isRegistered'] as bool;
      return isRegistered ? CheckEmailSuccess() : CheckEmailInitial();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(RegisterState state) {
    return {
      'isRegistered': state.isRegistered,
    };
  }
}
