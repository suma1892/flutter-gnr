import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/core/styles/app_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_get_ride_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_get_ride_app/features/register-password/presentation/pages/register_password_page.dart';
import 'package:flutter_get_ride_app/features/register/presentation/bloc/check_email_bloc.dart';
import 'package:flutter_get_ride_app/features/register/presentation/bloc/check_email_event.dart';
import 'package:flutter_get_ride_app/features/register/presentation/bloc/check_email_state.dart';
import 'package:flutter_get_ride_app/shared/presetation/widgets/text_input.dart';

import 'package:flutter_get_ride_app/shared/utils/validations.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<CheckEmailBloc, CheckEmailState>(
          listener: (context, state) {
            if (state is CheckEmailSuccess) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RegisterPasswordPage()));
            } else if (state is CheckEmailFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Image.asset(
                        Helper.getIconPath('mainLogo'),
                        height: 43,
                        width: 101,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.signUp,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.navy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    AppLocalizations.of(context)!.signUpDesc,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 32),
                  TextInput(
                    label: AppLocalizations.of(context)!.fullName,
                    hintText: AppLocalizations.of(context)!.fullNamePlaceholder,
                    controller: fullnameController,
                  ),
                  const SizedBox(height: 16),
                  TextInput(
                    label: 'Email',
                    hintText: AppLocalizations.of(context)!.emailPlaceholder,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 40),
                  BlocBuilder<CheckEmailBloc, CheckEmailState>(
                    builder: (context, state) {
                      if (state is CheckEmailLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text;
                            // final fullname = fullnameController.text;

                            context.read<CheckEmailBloc>().add(
                                  CheckEmailSubmitted(email: email),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Mohon lengkapi semua field'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: AppColors.navy,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.signUp,
                          style: AppTextStyle.smallWhite.merge(
                            const TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        'Sudah punya akun? Masuk',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
