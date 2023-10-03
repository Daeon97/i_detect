// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:i_detect/cubits/efotainer_cubit/efotainer_cubit.dart';
import 'package:i_detect/cubits/theme_cubit/theme_cubit.dart';
import 'package:i_detect/repositories/efotainer_repository.dart';
import 'package:i_detect/repositories/theme_repository.dart';
import 'package:i_detect/services/database_service.dart';

final sl = GetIt.I;

void registerServices() {
  sl

    // Cubits
    ..registerFactory<ThemeCubit>(
      () => ThemeCubit(
        sl(),
      ),
    )
    ..registerFactory<EfotainerCubit>(
      () => EfotainerCubit(
        sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<ThemeRepository>(
      ThemeRepositoryImplementation.new,
    )
    ..registerLazySingleton<EfotainerRepository>(
      () => EfotainerRepositoryImplementation(
        sl(),
      ),
    )

    // Services
    ..registerLazySingleton<DatabaseService>(
      AmazonDynamoDBService.new,
    );

  // External

  // Primitives
}
