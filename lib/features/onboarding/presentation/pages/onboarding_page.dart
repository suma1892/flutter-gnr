import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_get_ride_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_get_ride_app/features/register-verify-otp/presentation/bloc/verify_otp_bloc.dart';
import 'package:flutter_get_ride_app/features/register-verify-otp/presentation/bloc/verify_otp_state.dart';
import 'package:flutter_get_ride_app/shared/presetation/pages/bottom_tab.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    // Gunakan addPostFrameCallback untuk memeriksa status login setelah frame dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() {
    final loginState = context.read<LoginBloc>().state;
    final verifyOtpState = context.read<VerifyOtpBloc>().state;

    if (_isUserLoggedIn(loginState, verifyOtpState)) {
      // Jika sudah login, arahkan ke HomePage
      _navigateToHome();
    } else {
      // Jika belum login, arahkan ke LoginPage
      _navigateToLogin();
    }
  }

  bool _isUserLoggedIn(LoginState loginState, VerifyOtpState verifyOtpState) {
    if (loginState is LoginSuccess && loginState.isLogin) {
      return true;
    }
    if (verifyOtpState is VerifyOtpSuccess && verifyOtpState.isLogin) {
      return true;
    }
    return false;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const BottomTab()),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          Helper.getIconPath('mainLogo'),
          width: 240,
          height: 102,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
