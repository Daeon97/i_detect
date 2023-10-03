// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

abstract interface class ThemeRepository {
  ThemeData get lightTheme;

  ThemeData get darkTheme;
}

final class ThemeRepositoryImplementation implements ThemeRepository {
  @override
  ThemeData get lightTheme => throw UnimplementedError();

  @override
  ThemeData get darkTheme => throw UnimplementedError();
}
