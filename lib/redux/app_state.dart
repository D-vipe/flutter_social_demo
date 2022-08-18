import 'package:flutter/material.dart';
import 'package:flutter_social_demo/screens/posts/view_model/post_detail_view_model.dart';
import 'package:flutter_social_demo/screens/posts/view_model/posts_view_model.dart';
import 'package:flutter_social_demo/screens/users_list/view_model/users_list_view_model.dart';

@immutable
class AppState {
  final UsersListViewModel usersListState;
  final PostsViewModel postsScreenState;
  final PostDetailViewModel postDetailScreenState;

  const AppState({
    required this.usersListState,
    required this.postsScreenState,
    required this.postDetailScreenState,
  });

  factory AppState.initialState() => AppState(
        usersListState: UsersListViewModel.initial(),
        postsScreenState: PostsViewModel.initial(),
        postDetailScreenState: PostDetailViewModel.initial(),
      );

  AppState copyWith({
    required UsersListViewModel usersListState,
    PostsViewModel? postsScreenState,
    PostDetailViewModel? postDetailScreenState,
  }) =>
      AppState(
        usersListState: usersListState,
        postsScreenState: postsScreenState ?? this.postsScreenState,
        postDetailScreenState:
            postDetailScreenState ?? this.postDetailScreenState,
      );
}
