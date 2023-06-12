// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:i_detect/cubits/details_cubit/details_cubit.dart';
import 'package:i_detect/cubits/location_details_cubit/location_details_cubit.dart';
import 'package:i_detect/repositories/location_repository.dart';
import 'package:i_detect/repositories/tracker_repository.dart';
import 'package:i_detect/services/location_service.dart';
import 'package:i_detect/services/mqtt_service.dart';
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
    ..registerFactory<LocationDetailsCubit>(
      () => LocationDetailsCubit(
        locationRepository: sl(),
      ),
    )

    // Repositories
    ..registerLazySingleton<TrackerRepository>(
      () => TrackerRepository(
        trackerService: sl(),
      ),
    )
    ..registerLazySingleton<LocationRepository>(
      () => LocationRepository(
        locationService: sl(),
      ),
    )

    // Services
    ..registerLazySingleton<TrackerService>(
      () => TrackerService(
        mqttService: sl(),
      ),
    )
    ..registerLazySingleton<LocationService>(
      () => const LocationService(),
    )
    ..registerLazySingleton<MqttService>(
      () => MqttService(
        securityContext: sl(),
        mqttServerClient: sl(),
      ),
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
      () => 'i_detect',
      instanceName: 'clientIdentifier',
    );
}
