part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileError extends ProfileState {
  final String error;

  ProfileError({required this.error});
}

class ProfileRequested extends ProfileState {}

class ProfileReceived extends ProfileState {
  final Profile data;

  ProfileReceived({required this.data});

  @override
  List<Object?> get props => [data];
}
