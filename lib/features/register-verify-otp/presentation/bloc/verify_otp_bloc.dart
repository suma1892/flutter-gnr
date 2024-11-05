import 'dart:developer' as developer;
import 'package:flutter_get_ride_app/core/network/dio_client.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'verify_otp_event.dart';
import 'verify_otp_state.dart';

class VerifyOtpBloc extends HydratedBloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc() : super(VerifyOtpInitial()) {
    on<VerifyOtpSubmitted>((event, emit) async {
      emit(VerifyOtpLoading());

      try {
        var client = DioClient();
        final response =
            await client.dio.post('/authorization/register/confirmation', data: {
          'session': event.session,
          'token': event.token,
        });
        developer.log('Response Data: ${response.data}');

        if (response.statusCode == 200) {
          developer.log('masuk 200 ');
          final responseData = response.data;
          final accessToken = responseData['access_token'];
          final refreshToken = responseData['refresh_token'];

          if (accessToken != null && accessToken.isNotEmpty &&
              refreshToken != null && refreshToken.isNotEmpty) {
            emit(VerifyOtpSuccess(accessToken, refreshToken));
          } else {
            emit(VerifyOtpFailure(error: 'Kode salah.'));
          }
        }
      } catch (e) {
        developer.log('error: ${e.toString()}');
        emit(VerifyOtpFailure(error: e.toString()));
      }
    });
  }

  @override
  VerifyOtpState? fromJson(Map<String, dynamic> json) {
    try {
      final isLogin = json['isLogin'] as bool;
      final accessToken = json['accessToken'] as String?;
      final refreshToken = json['refreshToken'] as String?;
      
      return isLogin
          ? VerifyOtpSuccess(accessToken!, refreshToken!)
          : VerifyOtpInitial();
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(VerifyOtpState state) {
    return {
      'isLogin': state.isLogin,
      'accessToken': state.accessToken,
      'refreshToken': state.refreshToken,
    };
  }
}
