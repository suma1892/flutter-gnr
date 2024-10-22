import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_event.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_get_ride_app/features/login/presentation/widgets/text_input.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_get_ride_app/features/login/presentation/widgets/text_input_pasword.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Berhasil!')),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Gagal: ${state.error}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Spacer(),
                    Image.asset(
                      Helper.getIconPath('mainLogo'),
                      height: 43,
                      width: 101,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.hello_world,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Masukan Email untuk login ke Get & Ride',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 32),
                TextInput(
                  label: 'Email',
                  hintText: 'Masukkan email Anda',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16),
                TextInputPassword(
                  label: 'Password',
                  hintText: 'Masukkan password Anda',
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Aksi untuk lupa password
                    },
                    child: Text('Lupa Password?'),
                  ),
                ),
                SizedBox(height: 16),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        context.read<LoginBloc>().add(
                              LoginSubmitted(
                                  email: email, password: password),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text('Login'),
                    );
                  },
                ),
                SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () {
                    // Aksi untuk mencoba Get & Ride
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Coba Get & Ride'),
                ),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    'Atau login menggunakan',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        Helper.getIconPath('mainLogo'),
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        Helper.getIconPath('mainLogo'),
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Image.asset(
                        Helper.getIconPath('mainLogo'),
                        width: 50,
                        height: 50,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Aksi untuk mendaftar
                    },
                    child: Text(
                      'Belum punya akun? Daftar Sekarang',
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
    );
  }
}
