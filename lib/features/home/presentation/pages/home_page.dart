import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_header.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HomeHeader(),
              Text(AppLocalizations.of(context)!.loginDesc)
            ],
          ),
        ),
      ),
    );
  }
}
