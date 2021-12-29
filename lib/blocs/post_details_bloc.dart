import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/comment.dart';
import 'package:flutter_test_app_eclipse/api/models/post.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class PostDetailsBlocEvent {}

class PostDetailsBlocEventGetComments extends PostDetailsBlocEvent {}

class PostDetailsBlocEventSendComment extends PostDetailsBlocEvent {}

abstract class PostDetailsBlocState {}

class PostDetailsBlocStateInitial extends PostDetailsBlocState {}

class PostDetailsBlocStateFetched extends PostDetailsBlocState {}

class PostDetailsBlocStateError extends PostDetailsBlocState {
  final String message;

  PostDetailsBlocStateError(this.message);
}

class PostDetailsBlocStateSendCommentIsSuccess extends PostDetailsBlocState {}

class PostDetailsBloc extends Bloc<PostDetailsBlocEvent, PostDetailsBlocState> {
  PostDetailsBloc(this._dataProvider) : super(PostDetailsBlocStateInitial()) {
    on<PostDetailsBlocEventGetComments>((event, emit) async{
      try{
        if(comments.isEmpty){
          await _dataProvider.getComments();
        }
        _dataProvider.getCommentCurrentPost();
        emit(PostDetailsBlocStateFetched());
      }catch(e){
        emit(PostDetailsBlocStateError('Произошла ошибка'));
        debugPrint(e.toString());
      }
    });
  }

  final DataProvider _dataProvider;

  List<Comment> get comments => _dataProvider.commentsCurrentPost;

  Post get currentPost => _dataProvider.currentPost;
}
