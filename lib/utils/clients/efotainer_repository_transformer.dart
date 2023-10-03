// ignore_for_file: public_member_api_docs

import 'package:dartz/dartz.dart';
import 'package:i_detect/models/failure.dart';
import 'package:i_detect/resources/strings.dart';

mixin class EfotainerRepositoryTransformer {
  Future<Either<Failure, T>> transform<T>({
    required Future<T> initiator,
  }) async {
    try {
      final model = await initiator;
      return Right(
          model,
      );
    } catch (e) {
      String? reason;
      if (e is String) {
        reason = e;
      }

      return Left(
        Failure(
          reason ?? error,
        ),
      );
    }
  }
}
