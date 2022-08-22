import 'package:flutter_social_demo/redux/actions/profile_actions.dart';
import 'package:flutter_social_demo/screens/profile/view_model/profile_view_model.dart';
import 'package:redux/redux.dart';

final profileReducer = combineReducers<ProfileViewModel>([
  TypedReducer<ProfileViewModel, GetProfileSucceedAction>(_fetch),
  TypedReducer<ProfileViewModel, RefreshProfileAction>(_refresh),
  TypedReducer<ProfileViewModel, ProfileErrorAction>(_errorHandler),
]);

ProfileViewModel _fetch(
    ProfileViewModel state, GetProfileSucceedAction action) {
  return state.copyWith(
      isLoading: false, isRefreshing: false, profile: action.data);
}

ProfileViewModel _refresh(ProfileViewModel state, RefreshProfileAction action) {
  return state.copyWith(isLoading: false, isRefreshing: true);
}

ProfileViewModel _errorHandler(
    ProfileViewModel state, ProfileErrorAction action) {
  return state.copyWith(
      isLoading: false,
      isRefreshing: false,
      isError: true,
      errorMessage: action.errorMessage);
}
