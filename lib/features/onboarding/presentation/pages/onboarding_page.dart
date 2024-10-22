import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/icon_name.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/login/presentation/pages/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  void initState() {
    super.initState();
    // Delay selama 2 detik, lalu arahkan ke halaman Home
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
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
