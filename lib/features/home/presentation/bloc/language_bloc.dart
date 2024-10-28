// language_bloc.dart
import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class SelectLanguage extends LanguageEvent {
  final String language;

  const SelectLanguage(this.language);

  @override
  List<Object> get props => [language];
}

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(Locale('id'))) {
    on<SelectLanguage>((event, emit) {
      Locale newLocale;
      switch (event.language) {
        case 'English':
          newLocale = const Locale('en');
          break;
        case '中文':
          newLocale = const Locale('zh');
          break;
        case 'Indonesia':
        default:
          newLocale = const Locale('id');
      }
      emit(LanguageState(newLocale));
    });
  }
}
