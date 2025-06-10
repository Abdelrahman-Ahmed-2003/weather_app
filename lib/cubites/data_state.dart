part of 'data_cubit.dart';

@immutable
sealed class DataState {}

final class DataInitial extends DataState {}

class DataLoaded extends DataState {
  DataLoaded();
}

class DataLoading extends DataState {
  DataLoading();
}

class SetPosition extends DataState {
  SetPosition();
}

class SetDate extends DataState {
  SetDate();
}

class DataError extends DataState{
  final String error;
  DataError(this.error);
}