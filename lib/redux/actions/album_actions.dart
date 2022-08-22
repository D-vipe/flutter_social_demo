// Project imports:
import 'package:flutter_social_demo/api/models/models.dart';

// ALBUM SCREEN ACTIONS
class GetAlbumListAction {}

class GetAlbumsProfileAction {}

class GetAlbumListSucceedAction {
  final List<Album> albumsList;

  GetAlbumListSucceedAction({required this.albumsList});
}

class RefreshAlbumListAction {
  final List<Album> oldList;

  RefreshAlbumListAction({required this.oldList});
}
// ALBUM SCREEN ACTIONS END

// DETAIL SCREEN ACTIONS
class GetAlbumDetailAction {
  final int albumId;

  GetAlbumDetailAction({required this.albumId});
}

class GetAlbumDetailSuccessAction {
  final Album data;

  GetAlbumDetailSuccessAction({required this.data});
}
// DETAIL SCREEN ACTIONS END

class AlbumErrorAction {
  final String errorMessage;

  AlbumErrorAction({required this.errorMessage});
}
