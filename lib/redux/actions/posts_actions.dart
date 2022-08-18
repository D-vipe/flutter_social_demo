import 'package:flutter_social_demo/models/models.dart';

class GetPostListAction {}

class GetPostListSucceedAction {
  final List<Post> postList;

  GetPostListSucceedAction({required this.postList});
}

class GetPostListErrorAction {
  final String errorMessage;

  GetPostListErrorAction({required this.errorMessage});
}

class RefreshPostListAction {
  final List<Post> oldList;

  RefreshPostListAction({required this.oldList});
}
