import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_state.dart';
import 'dart:developer' as developer;

class ApiInterceptor extends Interceptor {
  final Dio dio;
  final LoginBloc authenticationBloc;

  ApiInterceptor({required this.dio, required this.authenticationBloc});

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Tambahkan header authorization jika token tersedia
    final state = authenticationBloc.state;
    final accessToken = state.accessToken;
    developer.log('state = $accessToken');
    if (state is LoginSuccess && accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Jika mendapatkan 401 Unauthorized, coba refresh token
      final success = await _refreshToken();

      if (success) {
        // Jika refresh berhasil, ulangi permintaan
        final options = err.requestOptions;
        final newOptions = Options(
          method: options.method,
          headers: options.headers,
        );
        try {
          final response = await dio.request(
            options.path,
            data: options.data,
            queryParameters: options.queryParameters,
            options: newOptions,
          );
          return handler.resolve(response);
        } catch (e) {
          return handler.reject(DioError(requestOptions: options, error: e));
        }
      }
    }
    return handler
        .next(err); // Jika bukan 401 atau refresh gagal, lemparkan error
  }

  Future<bool> _refreshToken() async {
    try {
      final state = authenticationBloc.state;
      if (state is LoginSuccess) {
        // Request untuk mendapatkan token baru menggunakan refresh token
        final response = await dio.post('/auth/refresh-token', data: {
          'refresh_token': state.refreshToken,
        });

        // Jika berhasil, update token di AuthenticationBloc
        if (response.statusCode == 200) {
          final newToken = response.data['access_token'];
          final newRefreshToken = response.data['refresh_token'];
          authenticationBloc.add(TokenRefreshed(
              // token: newToken,
              // refreshToken: newRefreshToken,
              newAccessToken: newToken,
              newRefreshToken: newRefreshToken));
          return true;
        }
      }
    } catch (e) {
      print('Gagal memperbarui token: $e');
    }
    return false;
  }
}
