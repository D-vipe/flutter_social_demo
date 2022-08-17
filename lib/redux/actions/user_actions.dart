import 'package:flutter_social_demo/models/models.dart';

class GetUsersListAction {}

class GetUsersListSucceedAction {
  final List<User> usersList;

  GetUsersListSucceedAction({required this.usersList});
}

class GetMoreUsersSucceedAction {
  final List<User> usersList;

  GetMoreUsersSucceedAction({required this.usersList});
}

class RefreshUsersSucceedAction {
  final List<User> usersList;

  RefreshUsersSucceedAction({required this.usersList});
}

class GetUsersListErrorAction {
  final String errorMessage;

  GetUsersListErrorAction(this.errorMessage);
}

class RefreshUsersListAction {
  final List<User> oldList;

  RefreshUsersListAction({required this.oldList});
}

class LoadMoreUsersAction {
  final List<User> oldList;

  LoadMoreUsersAction({required this.oldList});
}
