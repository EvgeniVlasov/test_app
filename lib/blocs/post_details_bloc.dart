import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/comment.dart';
import 'package:flutter_test_app_eclipse/api/models/post.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/response_send_comment.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class PostDetailsBlocEvent {}

class PostDetailsBlocEventGetComments extends PostDetailsBlocEvent {}

class PostDetailsBlocEventSendComment extends PostDetailsBlocEvent {}

abstract class PostDetailsBlocState {}

class PostDetailsBlocStateInitial extends PostDetailsBlocState {}

class PostDetailsBlocStateFetched extends PostDetailsBlocState {}

class PostDetailsBlocStateSendCommentIsSuccess extends PostDetailsBlocState {}

class PostDetailsBloc extends Bloc<PostDetailsBlocEvent, PostDetailsBlocState> {
  PostDetailsBloc(this._dataProvider) : super(PostDetailsBlocStateInitial()) {
    on<PostDetailsBlocEventGetComments>((event, emit) async {
      try {
        if (comments.isEmpty) {
          await _dataProvider.getComments();
        }
        _dataProvider.getCommentCurrentPost();
        emit(PostDetailsBlocStateFetched());
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    on<PostDetailsBlocEventSendComment>((event, emit) async {
      try {
        await _dataProvider.sendComment(
            mail: fieldInputMail,
            name: fieldInputName,
            body: fieldInputBody,
            postId: currentPost.id);
        _dataProvider.getYourComments();
        fieldInputMail = '';
        fieldInputBody = '';
        fieldInputName = '';
        emit(PostDetailsBlocStateSendCommentIsSuccess());
      } catch (e) {
        debugPrint(e.toString());
      }
    });
  }

  final DataProvider _dataProvider;

  List<Comment> get comments => _dataProvider.commentsCurrentPost;

  Post get currentPost => _dataProvider.currentPost;

  SendCommentResponse get yourComment => _dataProvider.yourComment;

  List<SendCommentResponse> get yourComments => _dataProvider.yourComments;

  String fieldInputMail = '';
  String fieldInputName = '';
  String fieldInputBody = '';
}
