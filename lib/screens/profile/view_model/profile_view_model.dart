// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/profile_model.dart';

@immutable
class ProfileViewModel {
  final bool isLoading;
  final bool? isRefreshing;
  final bool? isError;
  final String? errorMessage;
  final Profile? profile;

  const ProfileViewModel({
    required this.isLoading,
    this.isRefreshing,
    this.isError,
    this.errorMessage,
    this.profile,
  });

  factory ProfileViewModel.initial() {
    return const ProfileViewModel(
      isLoading: true,
    );
  }

  ProfileViewModel copyWith({
    required bool isLoading,
    bool? isRefreshing,
    bool? isError,
    String? errorMessage,
    Profile? profile,
  }) {
    return ProfileViewModel(
        isLoading: isLoading,
        isRefreshing: isRefreshing ?? this.isRefreshing,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage,
        profile: profile ?? this.profile);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isRefreshing == other.isRefreshing &&
          isError == other.isError &&
          errorMessage == other.errorMessage &&
          profile == other.profile;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      isRefreshing.hashCode ^
      isError.hashCode ^
      errorMessage.hashCode ^
      profile.hashCode;
}
