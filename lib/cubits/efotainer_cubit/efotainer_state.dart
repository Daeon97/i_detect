// ignore_for_file: public_member_api_docs

part of 'efotainer_cubit.dart';

abstract final class EfotainerState extends Equatable {
  const EfotainerState();

  @override
  List<Object> get props => [];
}

final class EfotainerInitialState extends EfotainerState {
  const EfotainerInitialState();

  @override
  List<Object> get props => [];
}

final class LoadingEfotainerState extends EfotainerState {
  const LoadingEfotainerState();

  @override
  List<Object> get props => [];
}

final class LoadedEfotainerState extends EfotainerState {
  const LoadedEfotainerState(
    this.efotainer,
  );

  final Efotainer efotainer;

  @override
  List<Object> get props => [
        efotainer,
      ];
}

final class FailedToLoadEfotainerState extends EfotainerState {
  const FailedToLoadEfotainerState(
    this.reason,
  );

  final String reason;

  @override
  List<Object> get props => [
        reason,
      ];
}
