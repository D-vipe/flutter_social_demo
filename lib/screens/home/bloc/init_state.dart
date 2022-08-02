part of 'init_cubit.dart';

abstract class InitialState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialInit extends InitialState {}

class InitialError extends InitialState {
  final String error;

  InitialError({required this.error});
}

class InitialRequested extends InitialState {}

class InitialReceived extends InitialState {
  final Profile data;

  InitialReceived({required this.data});

  @override
  List<Object?> get props => [data];
}
