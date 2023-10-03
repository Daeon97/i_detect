// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/models/failure.dart';
import 'package:i_detect/services/database_service.dart';
import 'package:i_detect/utils/clients/efotainer_repository_transformer.dart';

abstract interface class EfotainerRepository {
  Future<Either<Failure, Efotainer>> get data;

  Future<Either<Failure, List<Efotainer>>> get history;
}

final class EfotainerRepositoryImplementation
    with EfotainerRepositoryTransformer
    implements EfotainerRepository {
  const EfotainerRepositoryImplementation(
    DatabaseService databaseService,
  ) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<Either<Failure, Efotainer>> get data => transform<Efotainer>(
        initiator: _databaseService.data,
      );

  @override
  Future<Either<Failure, List<Efotainer>>> get history =>
      transform<List<Efotainer>>(
        initiator: _databaseService.history,
      );
}
