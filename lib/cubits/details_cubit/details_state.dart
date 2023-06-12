// ignore_for_file: public_member_api_docs

part of 'details_cubit.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitialState extends DetailsState {
  const DetailsInitialState();

  @override
  List<Object> get props => [];
}

class LoadingDetailsState extends DetailsState {
  const LoadingDetailsState();

  @override
  List<Object> get props => [];
}

class LoadedDetailsState extends DetailsState {
  const LoadedDetailsState(
    this.details,
  );

  final Details details;

  @override
  List<Object> get props => [
        details,
      ];
}

class FailedToLoadDetailsState extends DetailsState {
  const FailedToLoadDetailsState(
    this.errorMessage,
  );

  final String errorMessage;

  @override
  List<Object> get props => [
        errorMessage,
      ];
}
