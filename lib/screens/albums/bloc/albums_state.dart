part of 'albums_cubit.dart';

abstract class AlbumsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumError extends AlbumsState {
  final String error;

  AlbumError({required this.error});
}

class AlbumsRequested extends AlbumsState {}

class AlbumsReceived extends AlbumsState {
  final List<Album> list;

  AlbumsReceived({required this.list});

  @override
  List<Object?> get props => [list];
}

class AlbumDetailReceived extends AlbumsState {
  final Album? data;

  AlbumDetailReceived({required this.data});
}
