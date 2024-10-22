import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await dotenv.load(fileName: ".env.development");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('en'),
          supportedLocales: [
            Locale('en'), // English
            Locale('id'), // Indonesia
            Locale('cn'), // Mandarin
          ],
          home: OnboardingPage(),
        ));
  }
}
