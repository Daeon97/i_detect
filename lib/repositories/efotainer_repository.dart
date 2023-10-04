// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/models/failure.dart';
import 'package:i_detect/services/database_service.dart';
import 'package:i_detect/utils/clients/efotainer_repository_transformer.dart';
import 'package:i_detect/utils/enums.dart' as enums;

abstract interface class EfotainerRepository {
  Future<Either<Failure, Efotainer>> getData({
    List<enums.Field>? fields,
  });

  Future<Either<Failure, List<Efotainer>>> getHistory({
    List<enums.Field>? fields,
  });
}

final class EfotainerRepositoryImplementation
    with EfotainerRepositoryTransformer
    implements EfotainerRepository {
  const EfotainerRepositoryImplementation(
    DatabaseService databaseService,
  ) : _databaseService = databaseService;

  final DatabaseService _databaseService;

  @override
  Future<Either<Failure, Efotainer>> getData({
    List<enums.Field>? fields,
  }) =>
      transform<Efotainer>(
        initiator: _databaseService.getData(
          fields: fields,
        ),
      );

  @override
  Future<Either<Failure, List<Efotainer>>> getHistory({
    List<enums.Field>? fields,
  }) =>
      transform<List<Efotainer>>(
        initiator: _databaseService.getHistory(
          fields: fields,
        ),
      );
}
