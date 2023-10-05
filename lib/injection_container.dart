// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:i_detect/cubits/efotainer_history_cubit/efotainer_history_cubit.dart';
import 'package:i_detect/repositories/efotainer_repository.dart';
import 'package:i_detect/services/database_service.dart';

final sl = GetIt.I;

void registerServices() {
  sl

    // Cubits
    ..registerFactory<EfotainerHistoryCubit>(
      () => EfotainerHistoryCubit(
        sl(),
      ),
    )

    // Repositories
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
