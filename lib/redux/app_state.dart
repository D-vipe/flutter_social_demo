import 'package:flutter_social_demo/models/models.dart';

class AppState {
  final bool isLoading;
  final List<User>? usersList;

  AppState({
    required this.isLoading,
    this.usersList,
  });

  factory AppState.initialState() => AppState(isLoading: true, usersList: []);

  AppState copyWith({
    required bool isLoading,
    List<User>? usersList,
  }) =>
      AppState(
        isLoading: isLoading,
        usersList: usersList ?? this.usersList,
      );
}
