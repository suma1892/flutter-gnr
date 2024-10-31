import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/register/presentation/pages/register_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterVerifyOtpPage extends StatefulWidget {
  final UserData userData;

  const RegisterVerifyOtpPage({super.key, required this.userData});

  @override
  State<RegisterVerifyOtpPage> createState() => _RegisterVerifyOtpPageState();
}

class _RegisterVerifyOtpPageState extends State<RegisterVerifyOtpPage> {
  late Timer _timer;
  int _remainingTime = 300; // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Function to format time
  String _formatTime(int timeInSeconds) {
    final minutes = timeInSeconds ~/ 60;
    final seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back navigation
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.verification,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.chooseVerificationMethod,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: AppColors.grey4),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 40,
                  height: 50,
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [LengthLimitingTextInputFormatter(1)],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            // Countdown timer
            Text(
              _formatTime(_remainingTime),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 32),
            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _remainingTime > 0
                    ? () {
                        // Handle submit action
                      }
                    : null,
                child: const Text('Kirim'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
