// ignore_for_file: public_member_api_docs

part of 'efotainer_history_cubit.dart';

abstract final class EfotainerHistoryState extends Equatable {
  const EfotainerHistoryState();

  @override
  List<Object> get props => [];
}

final class EfotainerHistoryInitialState extends EfotainerHistoryState {
  const EfotainerHistoryInitialState();

  @override
  List<Object> get props => [];
}

final class LoadingEfotainerHistoryState extends EfotainerHistoryState {
  const LoadingEfotainerHistoryState();

  @override
  List<Object> get props => [];
}

final class LoadedEfotainerHistoryState extends EfotainerHistoryState {
  const LoadedEfotainerHistoryState(
    this.efotainerHistory,
  );

  final List<Efotainer> efotainerHistory;

  @override
  List<Object> get props => [
        efotainerHistory,
      ];
}

final class FailedToLoadEfotainerHistoryState extends EfotainerHistoryState {
  const FailedToLoadEfotainerHistoryState(
    this.failure,
  );

  final Failure failure;

  @override
  List<Object> get props => [
        failure,
      ];
}
