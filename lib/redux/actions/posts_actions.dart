import 'package:flutter_social_demo/api/models/models.dart';

class GetPostListAction {}

class GetPostListSucceedAction {
  final List<Post> postList;

  GetPostListSucceedAction({required this.postList});
}

class RefreshPostListAction {
  final List<Post> oldList;

  RefreshPostListAction({required this.oldList});
}

class PostErrorAction {
  final String errorMessage;

  PostErrorAction({required this.errorMessage});
}
