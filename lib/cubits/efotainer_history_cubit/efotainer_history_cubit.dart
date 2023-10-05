// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/models/failure.dart';
import 'package:i_detect/repositories/efotainer_repository.dart';
import 'package:i_detect/utils/enums.dart' as enums;

part 'efotainer_history_state.dart';

class EfotainerHistoryCubit extends Cubit<EfotainerHistoryState> {
  EfotainerHistoryCubit(
    EfotainerRepository efotainerRepository,
  )   : _efotainerRepository = efotainerRepository,
        super(
          const EfotainerHistoryInitialState(),
        );

  final EfotainerRepository _efotainerRepository;

  Future<void> getHistory({
    List<enums.Field>? fields,
  }) async {
    emit(
      const LoadingEfotainerHistoryState(),
    );
    final result = await _efotainerRepository.getHistory(
      fields: fields,
    );
    result.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToLoadEfotainerHistoryState(
          failure,
        ),
      );

  void _success(
    List<Efotainer> efotainerHistory,
  ) =>
      emit(
        LoadedEfotainerHistoryState(
          efotainerHistory,
        ),
      );
}
