import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('es'));

  void setSpanish() {
    state = const Locale('es');
  }

  void setEnglish() {
    state = const Locale('en');
  }

  void setQuechua() {
    state = const Locale('qu');
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
