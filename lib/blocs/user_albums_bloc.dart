import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/album.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class UserAlbumsBlocEvent {}

class UserAlbumsBlocEventGetData extends UserAlbumsBlocEvent {}

class UserAlbumsBlocGoPhotos extends UserAlbumsBlocEvent {
  final int albumId;

  UserAlbumsBlocGoPhotos(this.albumId);
}

abstract class UserAlbumsBlocState {}

class UserAlbumsBlocInitialState extends UserAlbumsBlocState {}

class UserAlbumsBlocStateDataFetched extends UserAlbumsBlocState {}

class UserAlbumsBlocStateGoScreenPhotos extends UserAlbumsBlocState {}

class UserAlbumsBlocStateError extends UserAlbumsBlocState {
  final String message;

  UserAlbumsBlocStateError(this.message);
}

class UserAlbumsBloc extends Bloc<UserAlbumsBlocEvent, UserAlbumsBlocState> {
  UserAlbumsBloc(this._dataProvider) : super(UserAlbumsBlocInitialState()) {
    on<UserAlbumsBlocEventGetData>((event, emit) async {
      try {
        if (albumsUser.isEmpty) {
          await _dataProvider.getAlbums();
        }
        _dataProvider.getAlbumsCurrentUser();
        emit(UserAlbumsBlocStateDataFetched());
      } catch (e) {
        debugPrint(e.toString());
        emit(UserAlbumsBlocStateError(
            'Неудалось загрузить список, попробуйте еще раз.'));
      }
    });
    on<UserAlbumsBlocGoPhotos>((event, emit) {
      _dataProvider.getCurrentAlbum(event.albumId);
      emit(UserAlbumsBlocStateGoScreenPhotos());
    });
  }

  final DataProvider _dataProvider;

  List<Album> get albumsUser => _dataProvider.albumsCurrentUser;
}
