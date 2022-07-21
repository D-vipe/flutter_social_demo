import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_demo/app/config/exceptions.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/repository/models/post_model.dart';
import 'package:flutter_social_demo/repository/post_repository.dart';

part 'posts_state.dart';

final PostRepository _repository = PostRepository();

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostInitial());

  Future<void> getList() async {
    try {
      emit(PostRequested());

      List<Post> postList = await _repository.getPostsList();

      emit(PostReceived(list: postList));
    } on ParseException {
      emit(PostError(error: GeneralErrors.parseError));
    } catch (e) {
      emit(PostError(error: e.toString()));
    }
  }

  Future<void> refreshList({required List<Post> oldList}) async {
    try {
      List<Post> userList = await _repository.getPostsList();

      emit(PostReceived(list: userList));
    } on ParseException {
      // return old value if something goes wrong
      emit(PostReceived(list: oldList));
    } on Exception {
      emit(PostReceived(list: oldList));
    }
  }

  // Future<void> getDetail({required Post })
}
