// login_bloc.dart
import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/network/dio_client.dart';
import 'package:flutter_get_ride_app/core/utils/constant/network_constant.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:dio/dio.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());
      final Dio dio = Dio();

      try {
        var client = DioClient();
        final response = await client.dio.post('/authorization', data: {
          'email': event.email,
          'password': event.password,
          'scope': 'app',
        });
        developer.log('Response Data: ${response.data}');

        if (response.statusCode == 200) {
          developer.log('masuk 200 ');
          final responseData = response.data;
          final accessToken = responseData['access_token'];
          final refreshToken = responseData['refresh_token'];

          if (accessToken != null && accessToken.isNotEmpty &&
              refreshToken != null && refreshToken.isNotEmpty) {
            emit(LoginSuccess(accessToken, refreshToken));
          } else {
            emit(LoginFailure(error: 'Login gagal. Periksa email dan password Anda.'));
          }
        } else {
          emit(LoginFailure(error: 'Server error: ${response.statusCode}'));
        }
      } catch (e) {
        developer.log(e.toString());
        emit(LoginFailure(error: e.toString()));
      }
    });

    on<TokenRefreshed>((event, emit) {
      emit(LoginSuccess(event.newAccessToken, event.newRefreshToken));
    });
  }

  @override
  LoginState? fromJson(Map<String, dynamic> json) {
    try {
      final isLogin = json['isLogin'] as bool;
      final accessToken = json['accessToken'] as String?;
      final refreshToken = json['refreshToken'] as String?;
      return isLogin
          ? LoginSuccess(accessToken!, refreshToken!)
          : LoginInitial();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    return {
      'isLogin': state.isLogin,
      'accessToken': state.accessToken,
      'refreshToken': state.refreshToken,
    };
  }
}
