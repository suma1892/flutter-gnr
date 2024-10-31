import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/language_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_state.dart';
// import 'package:flutter_get_ride_app/features/home/presentation/bloc/services_bloc.dart'; // Import Bloc untuk Services
import 'package:flutter_get_ride_app/shared/presetation/widgets/text_input.dart';
import 'dart:developer' as developer;

class ListLocation extends StatelessWidget {
  const ListLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Lokasi Anda',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 12),
              TextInput(
                hintText: 'Cari',
                label: '',
                errorMessage: '',
                keyboardType: TextInputType.text,
                controller: TextEditingController(),
              ),
              Expanded(
                child: BlocBuilder<ServicesBloc, ServicesState>(
                  builder: (context, state) {
                    developer.log('res loc = $state');
                    if (state is ServicesLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ServicesLoaded) {
                      List<Location> locations = state.locations;
                      developer.log('res loc2= $state');
                      return ListView.builder(
                        itemCount: locations.length,
                        itemBuilder: (context, index) {
                          final location = locations[index];
                          return ListTile(
                            title: Text(location.name),
                            subtitle: Text(location.timeZone),
                            onTap: () {
                              // Handle onTap jika perlu
                            },
                          );
                        },
                      );
                    } else if (state is ServicesError) {
                      return Center(child: Text('Error: ${state.message}'));
                    }
                    return Center(child: Text('Belum ada data lokasi.'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
      BuildContext context, String language, String flagPath) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return ListTile(
          leading:
              Image.asset(Helper.getIconPath(flagPath), width: 24, height: 24),
          title: Text(language),
          trailing: state.locale.languageCode == _getLocaleCode(language)
              ? Icon(Icons.check, color: Colors.blue)
              : null,
          onTap: () {
            // Mengirim event SelectLanguage ke LanguageBloc
            context.read<LanguageBloc>().add(SelectLanguage(language));
          },
        );
      },
    );
  }

  String _getLocaleCode(String language) {
    switch (language) {
      case 'English':
        return 'en';
      case '中文':
        return 'zh';
      case 'Indonesia':
      default:
        return 'id';
    }
  }
}
