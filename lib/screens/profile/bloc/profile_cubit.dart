// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/repository/profile_repository.dart';

part 'profile_state.dart';

final ProfileRepository _repository = ProfileRepository();

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> getProfile() async {
    try {
      emit(ProfileRequested());

      Profile data = await _repository.getUserProfile();

      emit(ProfileReceived(data: data));
    } on NotFoundException {
      emit(ProfileError(error: GeneralErrors.emptyData));
    } on ParseException {
      emit(ProfileError(error: GeneralErrors.parseError));
    } catch (e) {
      emit(ProfileError(error: e.toString()));
    }
  }

  Future<void> refreshProfile({required Profile? oldData}) async {
    try {
      Profile data = await _repository.getUserProfile();

      emit(ProfileReceived(data: data));
    } on ParseException {
      // return old value if something goes wrong
      if (oldData != null) {
        emit(ProfileReceived(data: oldData));
      } else {
        emit(ProfileError(error: GeneralErrors.emptyData));
      }
    } on Exception {
      if (oldData != null) {
        emit(ProfileReceived(data: oldData));
      } else {
        emit(ProfileError(error: GeneralErrors.emptyData));
      }
    }
  }
}
