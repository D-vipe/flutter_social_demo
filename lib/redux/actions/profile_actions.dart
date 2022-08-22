// Project imports:
import 'package:flutter_social_demo/api/models/models.dart';

class GetProfileAction {}

class GetProfileSucceedAction {
  final Profile data;

  GetProfileSucceedAction({required this.data});
}

class UpdateProfilePostsSuccess {
  final List<Post> posts;

  UpdateProfilePostsSuccess({required this.posts});
}

class UpdateProfileAlbumsSuccess {
  final List<Album> albums;

  UpdateProfileAlbumsSuccess({required this.albums});
}

class ProfileErrorAction {
  final String errorMessage;

  ProfileErrorAction({required this.errorMessage});
}

class RefreshProfileAction {
  final Profile oldProfile;

  RefreshProfileAction({required this.oldProfile});
}
