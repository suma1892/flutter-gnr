import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_get_ride_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// void main() async {
//   await dotenv.load(fileName: ".env.development");
//   runApp(const MainApp());
// }

Future<void> main() async {
  await dotenv.load(fileName: ".env.development");
  // final dio = Dio();
  // final authenticationBloc = LoginBloc();

  // dio.interceptors.add(
  //   ApiInterceptor(dio: dio, authenticationBloc: authenticationBloc),
  // );
  
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
        ],
        child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('id'),
          supportedLocales: [
            Locale('en'), // English
            Locale('id'), // Indonesia
            Locale('zh'), // Mandarin
          ],
          home: OnboardingPage(),
        ));
  }
}
