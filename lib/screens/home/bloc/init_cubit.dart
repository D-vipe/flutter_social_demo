// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_demo/api/models/models.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/repository/profile_repository.dart';

part 'init_state.dart';

final ProfileRepository _repository = ProfileRepository();

class InitialCubit extends Cubit<InitialState> {
  InitialCubit() : super(InitialInit());

  Future<void> getInitialData() async {
    try {
      emit(InitialRequested());

      Profile? data = await _repository.getUserProfile();

      emit(InitialReceived(data: data));
    } on ParseException {
      emit(InitialError(error: GeneralErrors.parseError));
    } catch (e) {
      emit(InitialError(error: e.toString()));
    }
  }
}
