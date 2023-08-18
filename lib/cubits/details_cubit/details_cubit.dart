// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:i_detect/errors/broker_failure.dart';
import 'package:i_detect/models/details.dart';
import 'package:i_detect/repositories/tracker_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit({
    required TrackerRepository trackerRepository,
  })  : _trackerRepository = trackerRepository,
        super(
          const DetailsInitialState(),
        );

  final TrackerRepository _trackerRepository;

  StreamSubscription<Either<BrokerFailure, Details>>? _streamSubscription;

  void startListeningDetails() {
    emit(
      const LoadingDetailsState(),
    );

    if (_streamSubscription != null) {
      _streamSubscription!.cancel();
      _streamSubscription = null;
    }

    _streamSubscription = _trackerRepository.trackerStream.listen(
      (
        brokerFailureOrDetails,
      ) {
        brokerFailureOrDetails.fold(
          _failedToLoadDetails,
          _loadedDetails,
        );
      },
    );
  }

  void _failedToLoadDetails(BrokerFailure brokerFailure) => emit(
        FailedToLoadDetailsState(
          brokerFailure.message,
        ),
      );

  void _loadedDetails(Details details) => emit(
        LoadedDetailsState(
          details,
        ),
      );

  void stopListeningDetails() {
    _streamSubscription!.cancel();
    _streamSubscription = null;
  }
}
