import 'package:flutter_social_demo/models/models.dart';

class GetUsersListAction {}

class GetUsersListSucceedAction {
  final List<User> usersList;

  GetUsersListSucceedAction(this.usersList);
}

class GetUsersListErrorAction {
  final String errorMessage;

  GetUsersListErrorAction(this.errorMessage);
}

class RefreshUsersListAction {
  final List<User> oldList;

  RefreshUsersListAction(this.oldList);
}

class LoadMoreUsersAction {
  final List<User> oldList;

  LoadMoreUsersAction(this.oldList);
}
