// ignore_for_file: public_member_api_docs, avoid_setters_without_getters

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:i_detect/repositories/theme_repository.dart';
import 'package:i_detect/utils/enums.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(
    ThemeRepository themeRepository,
  )   : _themeRepository = themeRepository,
        super(
          ThemeState(
            themeRepository.lightTheme,
          ),
        );

  final ThemeRepository _themeRepository;

  set theme(
    ThemeBrightness themeBrightness,
  ) =>
      emit(
        ThemeState(
          switch (themeBrightness) {
            ThemeBrightness.light => _themeRepository.lightTheme,
            ThemeBrightness.dark => _themeRepository.darkTheme,
          },
        ),
      );
}
