// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:i_detect/clients/mqtt_client.dart';
import 'package:i_detect/cubits/details_cubit/details_cubit.dart';
import 'package:i_detect/repositories/tracker_repository.dart';
import 'package:i_detect/services/storage_service.dart';
import 'package:i_detect/services/tracker_service.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

final sl = GetIt.I;

void initDependencyInjection() {
  sl

    // Cubits
    ..registerFactory<DetailsCubit>(
      () => DetailsCubit(
        trackerRepository: sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<TrackerRepository>(
      () => TrackerRepository(
        trackerService: sl(),
        storageService: sl(),
      ),
    )

    // Services
    ..registerLazySingleton<TrackerService>(
      () => TrackerService(
        mqttClient: sl(),
      ),
    )
    ..registerLazySingleton<MqttClient>(
      () => MqttClient(
        securityContext: sl(),
        mqttServerClient: sl(),
      ),
    )
    ..registerLazySingleton<StorageService>(
      StorageService.new,
    )

    // External
    ..registerLazySingleton<SecurityContext>(
      () => SecurityContext.defaultContext,
    )
    ..registerLazySingleton<MqttServerClient>(
      () => MqttServerClient(
        sl.get(
          instanceName: 'server',
        ),
        sl.get(
          instanceName: 'clientIdentifier',
        ),
      ),
    )

    // Primitives
    ..registerLazySingleton<String>(
      () => dotenv.env['IOT_CORE_SERVER_END_POINT']!,
      instanceName: 'server',
    )
    ..registerLazySingleton<String>(
      () => 'efotainer',
      instanceName: 'clientIdentifier',
    );
}
