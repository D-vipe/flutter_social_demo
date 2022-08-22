import 'package:flutter/material.dart';
import 'package:flutter_social_demo/screens/albums/view_model/album_detail_view_model.dart';
import 'package:flutter_social_demo/screens/albums/view_model/album_list_view_model.dart';
import 'package:flutter_social_demo/screens/posts/view_model/post_detail_view_model.dart';
import 'package:flutter_social_demo/screens/posts/view_model/posts_view_model.dart';
import 'package:flutter_social_demo/screens/profile/view_model/profile_view_model.dart';
import 'package:flutter_social_demo/screens/users_list/view_model/users_list_view_model.dart';

@immutable
class AppState {
  final UsersListViewModel usersListState;
  final PostsViewModel postsScreenState;
  final PostDetailViewModel postDetailScreenState;
  final AlbumListViewModel albumsScreenState;
  final AlbumDetailViewModel albumDetailScreenState;
  final ProfileViewModel profileScreenState;

  const AppState({
    required this.usersListState,
    required this.postsScreenState,
    required this.postDetailScreenState,
    required this.albumsScreenState,
    required this.albumDetailScreenState,
    required this.profileScreenState,
  });

  factory AppState.initialState() => AppState(
        usersListState: UsersListViewModel.initial(),
        postsScreenState: PostsViewModel.initial(),
        postDetailScreenState: PostDetailViewModel.initial(),
        albumsScreenState: AlbumListViewModel.initial(),
        albumDetailScreenState: AlbumDetailViewModel.initial(),
        profileScreenState: ProfileViewModel.initial(),
      );

  AppState copyWith({
    required UsersListViewModel usersListState,
    PostsViewModel? postsScreenState,
    PostDetailViewModel? postDetailScreenState,
    AlbumListViewModel? albumsScreenState,
    AlbumDetailViewModel? albumDetailScreenState,
    ProfileViewModel? profileScreenState,
  }) =>
      AppState(
        usersListState: usersListState,
        postsScreenState: postsScreenState ?? this.postsScreenState,
        postDetailScreenState:
            postDetailScreenState ?? this.postDetailScreenState,
        albumsScreenState: albumsScreenState ?? this.albumsScreenState,
        albumDetailScreenState:
            albumDetailScreenState ?? this.albumDetailScreenState,
        profileScreenState: profileScreenState ?? this.profileScreenState,
      );
}
