// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/models.dart';

@immutable
class AlbumListViewModel {
  final bool isLoading;
  final bool? isRefreshing;
  final bool? isError;
  final String? errorMessage;
  final List<Album>? albumList;
  final List<Album>? albumListProfile;

  const AlbumListViewModel({
    required this.isLoading,
    this.isRefreshing,
    this.isError,
    this.errorMessage,
    this.albumList,
    this.albumListProfile,
  });

  factory AlbumListViewModel.initial() {
    return const AlbumListViewModel(isLoading: true);
  }

  AlbumListViewModel copyWith({
    required bool isLoading,
    bool? isRefreshing,
    bool? isError,
    String? errorMessage,
    List<Album>? albumList,
    List<Album>? albumListProfile,
  }) {
    return AlbumListViewModel(
      isLoading: isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      albumList: albumList ?? this.albumList,
      albumListProfile: albumListProfile ?? this.albumListProfile,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumListViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isRefreshing == other.isRefreshing &&
          isError == other.isError &&
          errorMessage == other.errorMessage &&
          albumList == other.albumList &&
          albumListProfile == other.albumListProfile;

  /// if we really want to check that postList has changed
  /// use the string below
  /// listsEqual(postList, other.postList);

  @override
  int get hashCode =>
      isLoading.hashCode ^
      isRefreshing.hashCode ^
      isError.hashCode ^
      errorMessage.hashCode ^
      albumListProfile.hashCode ^
      albumList.hashCode;
}
