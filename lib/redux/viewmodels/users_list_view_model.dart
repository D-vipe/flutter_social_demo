import 'package:flutter/material.dart';
import 'package:flutter_social_demo/models/user_model.dart';

@immutable
class UsersListViewModel {
  final bool isLoading;
  final bool isRefreshing;
  final bool isLoadingMore;
  final List<User>? usersList;

  const UsersListViewModel({
    required this.isLoading,
    required this.isRefreshing,
    required this.isLoadingMore,
    this.usersList,
  });

  UsersListViewModel copyWith(
      {required bool isLoading,
      required bool isRefreshing,
      required bool isLoadingMore,
      List<User>? usersList}) {
    return UsersListViewModel(
        isLoading: isLoading,
        isRefreshing: isRefreshing,
        isLoadingMore: isLoadingMore,
        usersList: usersList ?? this.usersList);
  }

  factory UsersListViewModel.initial() {
    return const UsersListViewModel(
        isLoading: true,
        isRefreshing: false,
        isLoadingMore: false,
        usersList: null);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsersListViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isRefreshing == other.isRefreshing &&
          isLoadingMore == other.isLoadingMore &&
          usersList == null;

  @override
  int get hashCode => isLoading.hashCode ^ usersList.hashCode;
}
