// login_bloc.dart
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'home_event.dart';
import 'home_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      try {
        final response = await http.post(
          Uri.parse(
              'https://api.getandride.staging.kretg.cloud/v1/authorization'),
          body: jsonEncode({
            // 'email': event.email,
            // 'password': event.password,
            'email': 'trisnaavr@gmail.com',
            'password': 'testing123',
            'scope': 'app',
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          developer.log('log measd', error: responseData['access_token']);

          if (responseData['access_token'] != null &&
              responseData['access_token'].isNotEmpty) {
            emit(LoginSuccess());
          } else {
            emit(LoginFailure(
                error: 'Login gagal. Periksa email dan password Anda.'));
          }
        } else {
          emit(LoginFailure(error: 'Server error: ${response.statusCode}'));
        }
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
