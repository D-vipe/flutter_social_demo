part of 'posts_cubit.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostsState {}

class PostError extends PostsState {
  final String error;

  PostError({required this.error});
}

class PostRequested extends PostsState {}

class PostReceived extends PostsState {
  final List<Post> list;

  PostReceived({required this.list});

  @override
  List<Object?> get props => [list];
}

class PostReceivedMore extends PostsState {
  final List<Post> list;

  PostReceivedMore({required this.list});

  @override
  List<Object?> get props => [list];
}

class PostDetailReceived extends PostsState {
  final Post? data;

  PostDetailReceived({required this.data});
}
