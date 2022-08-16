import 'package:flutter_social_demo/models/user_model.dart';
import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

final usersListReducer = combineReducers<List<User>>([
  TypedReducer<List<User>, GetUsersListSucceedAction>(_fetchUsers),
]);

List<User> _fetchUsers(List<User> usersList, GetUsersListSucceedAction action) {
  return action.usersList;
}
