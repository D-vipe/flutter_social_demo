import 'package:flutter_social_demo/redux/app_state.dart';
import 'package:flutter_social_demo/redux/reducers/loading_reducer.dart';
import 'package:flutter_social_demo/redux/reducers/users_list_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    usersList: usersListReducer(state.usersList ?? [], action),
  );
}
