import 'package:flutter/material.dart';
import 'package:flutter_social_demo/api/models/models.dart';

@immutable
class AlbumDetailViewModel {
  final bool isLoading;
  final bool? isError;
  final String? errorMessage;
  final Album? album;

  const AlbumDetailViewModel(
      {required this.isLoading, this.isError, this.errorMessage, this.album});

  AlbumDetailViewModel copyWith(
      {required bool isLoading,
      bool? isError,
      String? errorMessage,
      Album? album}) {
    return AlbumDetailViewModel(
        isLoading: isLoading,
        isError: isError ?? this.isError,
        errorMessage: errorMessage ?? this.errorMessage,
        album: album ?? this.album);
  }

  factory AlbumDetailViewModel.initial() {
    return const AlbumDetailViewModel(isLoading: true);
  }
}
