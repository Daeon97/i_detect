// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_detect/models/efotainer.dart';
import 'package:i_detect/models/failure.dart';
import 'package:i_detect/repositories/efotainer_repository.dart';

part 'efotainer_state.dart';

class EfotainerCubit extends Cubit<EfotainerState> {
  EfotainerCubit(
    EfotainerRepository efotainerRepository,
  )   : _efotainerRepository = efotainerRepository,
        super(
          const EfotainerInitialState(),
        );

  final EfotainerRepository _efotainerRepository;

  Future<void> get data async {
    emit(
      const LoadingEfotainerState(),
    );
    final result = await _efotainerRepository.data;
    result.fold(
      _failure,
      _success,
    );
  }

  void _failure(
    Failure failure,
  ) =>
      emit(
        FailedToLoadEfotainerState(
          failure.reason,
        ),
      );

  void _success(
    Efotainer efotainer,
  ) =>
      emit(
        LoadedEfotainerState(
          efotainer,
        ),
      );
}
