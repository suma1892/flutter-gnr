import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/register-send-otp/presentation/pages/register_send_otp_page.dart';
import 'package:flutter_get_ride_app/features/register/presentation/pages/register_page.dart';

class RegisterSelectVerificationMethodPage extends StatefulWidget {
  final UserData userData;

  const RegisterSelectVerificationMethodPage(
      {super.key, required this.userData});

  @override
  State<RegisterSelectVerificationMethodPage> createState() =>
      _RegisterSelectVerificationMethodPageState();
}

class _RegisterSelectVerificationMethodPageState
    extends State<RegisterSelectVerificationMethodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0,
      ),
      body: Padding(
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
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  UserData userData = UserData(
                      fullname: widget.userData.fullname,
                      email: widget.userData.email,
                      password: widget.userData.password,
                      passwordConfirmation:
                          widget.userData.passwordConfirmation);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          RegisterSendOtpPage(userData: userData)));
                },
                icon: Icon(Icons.email, color: Colors.black),
                label: Text(AppLocalizations.of(context)!.email,
                    style: TextStyle(color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
