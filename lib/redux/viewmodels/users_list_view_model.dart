import 'package:flutter/material.dart';
import 'package:flutter_social_demo/models/user_model.dart';

@immutable
class UsersListViewModel {
  final bool isLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final bool? isError;
  final String? errorMessage;
  final List<User>? usersList;

  const UsersListViewModel({
    required this.isLoading,
    required this.isRefreshing,
    required this.isLoadingMore,
    this.isError,
    this.errorMessage,
    this.usersList,
  });

  UsersListViewModel copyWith(
      {required bool isLoading,
      required bool isRefreshing,
      required bool isLoadingMore,
      bool? isError,
      String? errorMessage,
      List<User>? usersList}) {
    return UsersListViewModel(
        isLoading: isLoading,
        isRefreshing: isRefreshing,
        isLoadingMore: isLoadingMore,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage,
        usersList: usersList ?? this.usersList);
  }

  factory UsersListViewModel.initial() {
    return const UsersListViewModel(
      isLoading: true,
      isRefreshing: false,
      isLoadingMore: false,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersListViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isRefreshing == other.isRefreshing &&
          isLoadingMore == other.isLoadingMore &&
          isError == other.isError &&
          usersList == other.usersList;

  @override
  int get hashCode => isLoading.hashCode ^ usersList.hashCode;
}
