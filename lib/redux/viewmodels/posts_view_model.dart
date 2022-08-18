import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';
import 'package:flutter_social_demo/models/post_model.dart';

@immutable
class PostsViewModel {
  final bool isLoading;
  final bool? isRefreshing;
  final bool? isError;
  final String? errorMessage;
  final List<Post>? postList;

  const PostsViewModel({
    required this.isLoading,
    this.isRefreshing,
    this.isError,
    this.errorMessage,
    this.postList,
  });

  factory PostsViewModel.initial() {
    return const PostsViewModel(isLoading: true);
  }

  PostsViewModel copyWith(
      {required bool isLoading,
      bool? isRefreshing,
      bool? isError,
      String? errorMessage,
      List<Post>? postList}) {
    return PostsViewModel(
      isLoading: isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isError: isError ?? this.isError,
      errorMessage: errorMessage ?? this.errorMessage,
      postList: postList ?? this.postList,
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
      postList.hashCode;
}
