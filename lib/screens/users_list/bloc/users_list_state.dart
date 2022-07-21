part of 'users_list_cubit.dart';

abstract class UsersListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersListInitial extends UsersListState {}

class UsersListError extends UsersListState {
  final String error;

  UsersListError({required this.error});
}

class UsersListRequested extends UsersListState {}

class UsersListReceived extends UsersListState {
  final List<User> list;

  UsersListReceived({required this.list});

  @override
  List<Object?> get props => [list];
}

class UsersListReceivedMore extends UsersListState {
  final List<User> list;

  UsersListReceivedMore({required this.list});

  @override
  List<Object?> get props => [list];
}
