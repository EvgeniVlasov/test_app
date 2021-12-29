import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/post.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class UserPostsBlocEvent {}

class UserPostsBlocEventGetData extends UserPostsBlocEvent {}

class UserPostsBlocGoPost extends UserPostsBlocEvent {
  final int postId;

  UserPostsBlocGoPost(this.postId);
}

abstract class UserPostsBlocState {}

class UserPostsBlocInitialState extends UserPostsBlocState {}

class UserPostsBlocStateDataFetched extends UserPostsBlocState {}

class UserPostsBlocStateGoScreenPostDetails extends UserPostsBlocState {}

class UserPostsBlocStateError extends UserPostsBlocState {
  final String message;

  UserPostsBlocStateError(this.message);
}

class UserPostsBloc extends Bloc<UserPostsBlocEvent, UserPostsBlocState> {
  UserPostsBloc(this._dataProvider) : super(UserPostsBlocInitialState()) {
    on<UserPostsBlocEventGetData>((event, emit) async {
      try {
        if (posts.isEmpty) {
          await _dataProvider.getPosts();
        }
        _dataProvider.getPostsCurrentUser();
        emit(UserPostsBlocStateDataFetched());
      } catch (e) {
        debugPrint(e.toString());
        emit(UserPostsBlocStateError('Ошибка'));
      }
    });
    on<UserPostsBlocGoPost>((event, emit) {
      _dataProvider.getCurrentPost(event.postId);
      emit(UserPostsBlocStateGoScreenPostDetails());
    });
  }

  final DataProvider _dataProvider;

  List<Post> get posts => _dataProvider.postsCurrentUser;
}
