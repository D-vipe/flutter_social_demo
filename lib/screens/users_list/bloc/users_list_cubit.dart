// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/repository/models/user_model.dart';
import 'package:flutter_social_demo/repository/user_repository.dart';

part 'users_list_state.dart';

final UserRepository _repository = UserRepository();

class UsersListCubit extends Cubit<UsersListState> {
  UsersListCubit() : super(UsersListInitial());

  Future<void> getList() async {
    try {
      emit(UsersListRequested());

      List<User> userList = await _repository.getUsersList();

      emit(UsersListReceived(list: userList));
    } on ParseException {
      emit(UsersListError(error: GeneralErrors.parseError));
    } catch (e) {
      emit(UsersListError(error: e.toString()));
    }
  }

  Future<void> refreshList({required List<User> oldList}) async {
    try {
      List<User> userList = await _repository.getUsersList();

      emit(UsersListReceived(list: userList));
    } on ParseException {
      emit(UsersListReceived(list: oldList));
    } on Exception {
      emit(UsersListReceived(list: oldList));
    }
  }

  Future<void> loadMore({required List<User> oldList}) async {
    try {
      // API отдает только 10 юзеров. Сделаем имитацию подгрузки еще 10, если бы они были
      // по факту еще раз получим тех же пользователей и добавим к старому списку
      List<User> userList = await _repository.getUsersList();
      List<User> newList = oldList;

      if (userList.isNotEmpty) {
        newList.addAll(userList);
      }

      emit(UsersListReceivedMore(list: newList));
    } on ParseException {
      emit(UsersListReceived(list: oldList));
    } on Exception {
      emit(UsersListReceived(list: oldList));
    }
  }
}
