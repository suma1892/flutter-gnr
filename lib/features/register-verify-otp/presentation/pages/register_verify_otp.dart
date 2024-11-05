import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/core/styles/app_text_style.dart';
import 'package:flutter_get_ride_app/features/register-send-otp/presentation/bloc/register_bloc.dart';
import 'package:flutter_get_ride_app/features/register-send-otp/presentation/bloc/register_state.dart';
import 'package:flutter_get_ride_app/features/register-verify-otp/presentation/bloc/verify_otp_bloc.dart';
import 'package:flutter_get_ride_app/features/register-verify-otp/presentation/bloc/verify_otp_event.dart';
import 'package:flutter_get_ride_app/features/register-verify-otp/presentation/bloc/verify_otp_state.dart';
import 'package:flutter_get_ride_app/shared/presetation/pages/bottom_tab.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterVerifyOtpPage extends StatefulWidget {
  const RegisterVerifyOtpPage({super.key});

  @override
  State<RegisterVerifyOtpPage> createState() => _RegisterVerifyOtpPageState();
}

class _RegisterVerifyOtpPageState extends State<RegisterVerifyOtpPage> {
  late Timer _timer;
  int _remainingTime = 300; // 5 minutes in seconds
  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

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
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Function to format time
  String _formatTime(int timeInSeconds) {
    final minutes = timeInSeconds ~/ 60;
    final seconds = timeInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onOtpChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index + 1]);
    }
    if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_otpFocusNodes[index - 1]);
    }
  }

  String _getOtpCode() {
    return _otpControllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil state dari RegisterBloc
    final registerBlocState = context.watch<RegisterBloc>().state;

    String? session;
    if (registerBlocState is RegisterSuccess) {
      session = registerBlocState.session;
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<VerifyOtpBloc, VerifyOtpState>(
          listener: (context, state) {
            if (state is VerifyOtpSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomTab()));
              return;
            }

            if (state is VerifyOtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
              return;
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verifikasi',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Pilih metode verifikasi anda untuk keamanan dan melanjutkan pembayaran pemesanan anda',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: AppColors.grey4),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      height: 50,
                      child: TextField(
                        controller: _otpControllers[index],
                        focusNode: _otpFocusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(1)],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _onOtpChanged(index, value),
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
                BlocBuilder<VerifyOtpBloc, VerifyOtpState>(
                  builder: (context, state) {
                    if (state is VerifyOtpLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        String otpCode = _getOtpCode();
                        context.read<VerifyOtpBloc>().add(
                              VerifyOtpSubmitted(
                                  session: session ?? '', token: otpCode),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.navy,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        'Kirim',
                        style: AppTextStyle.smallWhite.merge(
                          const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
