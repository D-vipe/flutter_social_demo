import 'package:flutter_social_demo/redux/actions/user_actions.dart';
import 'package:redux/redux.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, GetUsersListAction>(_setLoading),
  TypedReducer<bool, GetUsersListSucceedAction>(_setLoaded),
  TypedReducer<bool, GetUsersListErrorAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}

bool _setLoading(bool state, action) {
  return true;
}
