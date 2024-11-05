import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/core/styles/app_text_style.dart';
import 'package:flutter_get_ride_app/features/register-send-otp/presentation/bloc/register_bloc.dart';
import 'package:flutter_get_ride_app/features/register-send-otp/presentation/bloc/register_event.dart';
import 'package:flutter_get_ride_app/features/register-send-otp/presentation/bloc/register_state.dart';
import 'package:flutter_get_ride_app/features/register-verify-otp/presentation/pages/register_verify_otp.dart';
import 'package:flutter_get_ride_app/features/register/presentation/pages/register_page.dart';

class RegisterSendOtpPage extends StatefulWidget {
  final UserData userData;

  const RegisterSendOtpPage({super.key, required this.userData});

  @override
  State<RegisterSendOtpPage> createState() => _RegisterSendOtpPageState();
}

class _RegisterSendOtpPageState extends State<RegisterSendOtpPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            elevation: 0,
          ),
          body: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegisterVerifyOtpPage()));
                return;
              }

              if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
                return;
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.verification,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    AppLocalizations.of(context)!.chooseVerificationMethod,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.grey4,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.sendOtpCodeToEmail,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    widget.userData.email,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30),
                  BlocBuilder<RegisterBloc, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          context.read<RegisterBloc>().add(
                                RegisterSubmitted(
                                    fullname: widget.userData.fullname,
                                    email: widget.userData.email,
                                    password: widget.userData.password,
                                    passwordConfirmation:
                                        widget.userData.passwordConfirmation),
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
                          'Kirim OTP',
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
          )),
    );
  }
}
