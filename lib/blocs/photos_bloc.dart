import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/api/models/photo.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';

abstract class PhotosBlocEvent {}

class PhotosBlocEventGetPhoto extends PhotosBlocEvent {}

abstract class PhotosBlocState {}

class PhotosBlocStateInitial extends PhotosBlocState {}

class PhotosBlocStateFetched extends PhotosBlocState {}

class PhotosBlocStateError extends PhotosBlocState {
  final String message;

  PhotosBlocStateError(this.message);
}

class PhotosBloc extends Bloc<PhotosBlocEvent, PhotosBlocState> {
  PhotosBloc(this._dataProvider) : super(PhotosBlocStateInitial()) {
    on<PhotosBlocEventGetPhoto>((event, emit) async{
      try {
        if(photos.isEmpty){
          await _dataProvider.getPhotos();
        }
        _dataProvider.getPhotosCurrentAlbum();
        emit(PhotosBlocStateFetched());
      } catch (e) {
        debugPrint(e.toString());
        emit(PhotosBlocStateError('Произошла ошибка'));
      }
    });
  }

  final DataProvider _dataProvider;

  List<Photo> get photos => _dataProvider.photosCurrentAlbum;
}
