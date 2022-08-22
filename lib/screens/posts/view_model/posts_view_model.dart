import 'package:flutter/material.dart';
import 'package:flutter_social_demo/api/models/models.dart';

@immutable
class PostsViewModel {
  final bool isLoading;
  final bool? isRefreshing;
  final bool? isError;
  final String? errorMessage;
  final List<Post>? postList;
  final List<Post>? postListProfile;

  const PostsViewModel({
    required this.isLoading,
    this.isRefreshing,
    this.isError,
    this.errorMessage,
    this.postList,
    this.postListProfile,
  });

  factory PostsViewModel.initial() {
    return const PostsViewModel(isLoading: true);
  }

  PostsViewModel copyWith({
    required bool isLoading,
    bool? isRefreshing,
    bool? isError,
    String? errorMessage,
    List<Post>? postList,
    List<Post>? postListProfile,
  }) {
    return PostsViewModel(
      isLoading: isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      postList: postList ?? this.postList,
      postListProfile: postListProfile ?? this.postListProfile,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          isRefreshing == other.isRefreshing &&
          isError == other.isError &&
          errorMessage == other.errorMessage &&
          postListProfile == other.postListProfile &&
          postList == other.postList;

  /// if we really want to check that postList has changed
  /// use the string below
  /// listsEqual(postList, other.postList);

  @override
  int get hashCode =>
      isLoading.hashCode ^
      isRefreshing.hashCode ^
      isError.hashCode ^
      errorMessage.hashCode ^
      postListProfile.hashCode ^
      postList.hashCode;
}
