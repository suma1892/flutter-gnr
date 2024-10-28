import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/language_bloc.dart';

class ListLanguage extends StatelessWidget {
  const ListLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Tinggi yang lebih besar untuk memberikan ruang cukup
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Pilih Bahasa',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: 12), // Menambahkan jarak antar elemen
              Expanded(
                child: ListView(
                  shrinkWrap: true, // Mengatur shrinkWrap menjadi true
                  children: [
                    _buildLanguageOption(context, 'Indonesia', 'ic_id'),
                    _buildLanguageOption(context, 'English', 'ic_en'),
                    _buildLanguageOption(context, '中文', 'ic_cn'),
                  ],
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
          leading: Image.asset(Helper.getIconPath(flagPath), width: 24, height: 24),
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
