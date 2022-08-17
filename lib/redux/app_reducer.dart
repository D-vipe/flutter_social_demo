import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/redux/reducers/users_list_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    usersListState: usersListReducer(state.usersListState, action),
  );
}
