// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:get_it/get_it.dart';

final sl = GetIt.I;

void initDependencyInjection() {
  // sl
  //
  // // Cubits
  //   ..registerFactory<BusDetailsCubit>(
  //         () => BusDetailsCubit(
  //       busTrackerRepository: sl(),
  //     ),
  //   )
  //   ..registerFactory<LocationDetailsCubit>(
  //         () => LocationDetailsCubit(
  //       locationRepository: sl(),
  //     ),
  //   )
  //
  // // Repositories
  //   ..registerLazySingleton<BusTrackerRepository>(
  //         () => BusTrackerRepository(
  //       busTrackerService: sl(),
  //     ),
  //   )
  //   ..registerLazySingleton<LocationRepository>(
  //         () => LocationRepository(
  //       locationService: sl(),
  //     ),
  //   )
  //
  // // Services
  //   ..registerLazySingleton<BusTrackerService>(
  //         () => BusTrackerService(
  //       mqttService: sl(),
  //     ),
  //   )
  //   ..registerLazySingleton<LocationService>(
  //         () => const LocationService(),
  //   )
  //   ..registerLazySingleton<MqttService>(
  //         () => MqttService(
  //       securityContext: sl(),
  //       mqttServerClient: sl(),
  //     ),
  //   )
  //
  // // External
  //   ..registerLazySingleton<SecurityContext>(
  //         () => SecurityContext.defaultContext,
  //   )
  //   ..registerLazySingleton<MqttServerClient>(
  //         () => MqttServerClient(
  //       sl.get(
  //         instanceName: 'server',
  //       ),
  //       sl.get(
  //         instanceName: 'clientIdentifier',
  //       ),
  //     ),
  //   )
  //
  // // Primitives
  //   ..registerLazySingleton<String>(
  //         () => dotenv.env['IOT_CORE_SERVER_END_POINT']!,
  //     instanceName: 'server',
  //   )
  //   ..registerLazySingleton<String>(
  //         () => 'bus_trackr',
  //     instanceName: 'clientIdentifier',
  //   );
}
