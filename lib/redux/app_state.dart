import 'package:flutter/material.dart';
import 'package:flutter_social_demo/redux/viewmodels/users_list_view_model.dart';

@immutable
class AppState {
  final UsersListViewModel usersListState;

  const AppState({
    required this.usersListState,
  });

  factory AppState.initialState() => AppState(
        usersListState: UsersListViewModel.initial(),
      );

  AppState copyWith({
    required UsersListViewModel usersListState,
  }) =>
      AppState(
        usersListState: usersListState,
      );
}
