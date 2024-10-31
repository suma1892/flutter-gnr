import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/language_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_get_ride_app/features/register/presentation/bloc/check_email_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env.development");

  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(MainApp());
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
        BlocProvider<CheckEmailBloc>(
          create: (context) => CheckEmailBloc(),
        ),
        BlocProvider<LanguageBloc>(
          create: (context) => LanguageBloc(),
        ),
        BlocProvider<ServicesBloc>(
          create: (context) => ServicesBloc(),
        ),
      ],
      child: BlocBuilder<LanguageBloc, LanguageState>(
        builder: (context, state) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: state.locale, // Menggunakan locale dari state
            supportedLocales: [
              Locale('en'), // English
              Locale('id'), // Indonesia
              Locale('zh'), // Mandarin
            ],
            home: OnboardingPage(),
          );
        },
      ),
    );
  }
}
