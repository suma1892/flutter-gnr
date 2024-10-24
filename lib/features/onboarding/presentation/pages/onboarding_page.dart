import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_get_ride_app/features/login/presentation/pages/login_page.dart';
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
    // Delay selama 2 detik, lalu periksa status login
    Future.delayed(const Duration(seconds: 2), () {
      final loginState = context.read<LoginBloc>().state;
      if (loginState is LoginSuccess && loginState.isLogin) {
        // Jika sudah login, arahkan ke HomePage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomTab()),
        );
      } else {
        // Jika belum login, arahkan ke LoginPage
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
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
