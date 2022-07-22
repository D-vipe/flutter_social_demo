import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/repository/album_repository.dart';
import 'package:flutter_social_demo/repository/models/album_model.dart';

part 'albums_state.dart';

final AlbumRepository _repository = AlbumRepository();

class AlbumsCubit extends Cubit<AlbumsState> {
  AlbumsCubit() : super(AlbumsInitial());

  Future<void> getList() async {
    try {
      emit(AlbumsRequested());

      List<Album> albumList = await _repository.getAlbumsList();

      emit(AlbumsReceived(list: albumList));
    } on ParseException {
      emit(AlbumError(error: GeneralErrors.parseError));
    } catch (e) {
      emit(AlbumError(error: e.toString()));
    }
  }

  Future<void> refreshList({required List<Album> oldList}) async {
    try {
      List<Album> userList = await _repository.getAlbumsList();

      emit(AlbumsReceived(list: userList));
    } on ParseException {
      // return old value if something goes wrong
      emit(AlbumsReceived(list: oldList));
    } on Exception {
      emit(AlbumsReceived(list: oldList));
    }
  }

  Future<void> getDetail({required int id}) async {
    try {
      emit(AlbumsRequested());

      Album? data = await _repository.getAlbumDetail(albumId: id);
      if (data == null) {
        emit(AlbumError(error: GeneralErrors.emptyData));
      }

      emit(AlbumDetailReceived(data: data));
    } on ParseException {
      emit(AlbumError(error: GeneralErrors.parseError));
    } catch (e) {
      emit(AlbumError(error: e.toString()));
    }
  }
}
