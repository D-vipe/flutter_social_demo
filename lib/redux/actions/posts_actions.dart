import 'package:flutter_social_demo/api/models/models.dart';

// LIST SCREEN ACTIONS
class GetPostListAction {}

class GetPostListSucceedAction {
  final List<Post> postList;

  GetPostListSucceedAction({required this.postList});
}

class RefreshPostListAction {
  final List<Post> oldList;

  RefreshPostListAction({required this.oldList});
}
// LIST SCREEN ACTIONS END

// DETAIL SCREEN ACTIONS
class GetPostDetailAction {
  final int postId;

  GetPostDetailAction({required this.postId});
}

class GetPostDetailSuccessAction {
  final Post data;

  GetPostDetailSuccessAction({required this.data});
}
// DETAIL SCREEN ACTIONS END

class PostErrorAction {
  final String errorMessage;

  PostErrorAction({required this.errorMessage});
}
