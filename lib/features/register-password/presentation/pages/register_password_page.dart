import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/core/styles/app_text_style.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_get_ride_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_get_ride_app/features/register-select-verification-method/presentation/pages/register_select_verification_method_page.dart';
import 'package:flutter_get_ride_app/features/register/presentation/pages/register_page.dart';
import 'package:flutter_get_ride_app/shared/presetation/widgets/text_input_pasword.dart';

class RegisterPasswordPage extends StatefulWidget {
  final UserData userData;

  const RegisterPasswordPage({super.key, required this.userData});

  @override
  State<RegisterPasswordPage> createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmationController =
      TextEditingController();

  bool validatePassword(String str) {
    final RegExp regex =
        RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!@#$%^&*]{8,}$');
    return regex.hasMatch(str);
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final password = passwordController.text;
      final passwordConfirmation = passwordConfirmationController.text;

      if (password == passwordConfirmation) {
        UserData userData = UserData(
            fullname: widget.userData.fullname,
            email: widget.userData.email,
            password: password);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  RegisterSelectVerificationMethodPage(userData: userData)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  AppLocalizations.of(context)!.errorConfirmationPassword)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon lengkapi semua field'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  AppLocalizations.of(context)!.createPassword,
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
                TextInputPassword(
                  label: AppLocalizations.of(context)!.password,
                  hintText: AppLocalizations.of(context)!.passwordPlaceholder,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!validatePassword(value)) {
                      return AppLocalizations.of(context)!
                          .errorValidatePassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextInputPassword(
                  label: AppLocalizations.of(context)!.passwordConfirmation,
                  hintText: AppLocalizations.of(context)!
                      .passwordConfirmationPlaceholder,
                  controller: passwordConfirmationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    } else if (!validatePassword(value)) {
                      return AppLocalizations.of(context)!
                          .errorValidatePassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: AppColors.navy,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.next,
                    style: AppTextStyle.smallWhite.merge(
                      const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
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
    );
  }
}
