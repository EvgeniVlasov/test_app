import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/album.dart';
import 'package:flutter_test_app_eclipse/api/models/photo.dart';
import 'package:flutter_test_app_eclipse/api/models/post.dart';
import 'package:flutter_test_app_eclipse/api/models/user.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class UserDetailsBlocEvent {}

class UserDetailsBlocGetDataEvent extends UserDetailsBlocEvent {}

class UserDetailsGoAllPostsScreenEvent extends UserDetailsBlocEvent {}

abstract class UserDetailsBlocState {}

class UserDetailsBlocInitialState extends UserDetailsBlocState {}

class UserDetailsBlocDataFetchedState extends UserDetailsBlocState {}

class UserDetailsGoAllPostsScreenState extends UserDetailsBlocState {}

class UserDetailsErrorState extends UserDetailsBlocState {
  final String message;

  UserDetailsErrorState(this.message);
}

class UserDetailsBloc extends Bloc<UserDetailsBlocEvent, UserDetailsBlocState> {
  UserDetailsBloc(this._dataProvider)
      : super(UserDetailsBlocInitialState()) {
    on<UserDetailsBlocGetDataEvent>((event, emit) async {
      try {
        await _dataProvider.getPosts();
        await _dataProvider.getAlbums();
        await _dataProvider.getPhotos();
        _dataProvider.getPostsCurrentUser();
        _dataProvider.getPreviewPostCurrentUser();
        _dataProvider.getAlbumsCurrentUser();
        _dataProvider.getPreviewAlbumsCurrentUser();

        emit(UserDetailsBlocDataFetchedState());
      } catch (e) {
        debugPrint(e.toString());
        emit(UserDetailsErrorState('Произошла ошибка, попробуйте еще раз.'));
      }
    });
  }

  final DataProvider _dataProvider;

  List<Post> get postsUser => _dataProvider.previewPostsCurrentUser;

  List<Album> get albumsUser => _dataProvider.previewAlbumsCurrentUser;

  List<Photo> get photosAlbum => _dataProvider.photosCurrentAlbum;

  User get currentUser => _dataProvider.currentUser;
}
