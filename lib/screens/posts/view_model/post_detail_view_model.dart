// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:flutter_social_demo/api/models/post_model.dart';

@immutable
class PostDetailViewModel {
  final bool isLoading;
  final bool? isError;
  final String? errorMessage;
  final Post? post;

  const PostDetailViewModel(
      {required this.isLoading, this.isError, this.errorMessage, this.post});

  PostDetailViewModel copyWith(
      {required bool isLoading,
      bool? isError,
      String? errorMessage,
      Post? post}) {
    return PostDetailViewModel(
        isLoading: isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage,
        post: post ?? this.post);
  }

  factory PostDetailViewModel.initial() {
    return const PostDetailViewModel(isLoading: true);
  }
}
