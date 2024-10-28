import 'package:dio/dio.dart';
import 'package:flutter_get_ride_app/core/network/api_interceptor.dart';
import 'package:flutter_get_ride_app/core/network/logger_interceptor.dart';
import 'package:flutter_get_ride_app/core/utils/constant/network_constant.dart';
import 'package:flutter_get_ride_app/core/utils/log/app_logger.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_state.dart';

class DioClient {
  DioClient() {
    addInterceptor(LogInterceptor());
  }

  final Dio dio = Dio(
    BaseOptions(baseUrl: apiUrl!),
  );

  void addInterceptor(Interceptor interceptor) {
    if (LoginBloc() is LoginSuccess) {
      dio.interceptors
          .add(ApiInterceptor(dio: dio, authenticationBloc: LoginBloc()));
    }

    dio.interceptors.add(interceptor);
    dio.interceptors.add(loggerInterceptor());
  }

  static LoggerInterceptor loggerInterceptor() {
    return LoggerInterceptor(
      logger,
      request: true,
      requestBody: true,
      error: true,
      responseBody: true,
      responseHeader: false,
      requestHeader: true,
    );
  }
}
