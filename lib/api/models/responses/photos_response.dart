import 'package:flutter_test_app_eclipse/api/models/photo.dart';

class PhotosResponse{
  List<Photo> photos =[];

  PhotosResponse.fromMap(List resp){
    List photosArray = List.castFrom(resp);
    for (var photo in photosArray) {
      photos.add(Photo.fromMap(photo));
    }
  }
}