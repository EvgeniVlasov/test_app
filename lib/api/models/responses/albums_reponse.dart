import 'package:flutter_test_app_eclipse/api/models/album.dart';

class AlbumsResponse {
  List<Album> albums = [];

  AlbumsResponse.fromMap(List resp) {
    List albumsArray = List.castFrom(resp);
    for (var album in albumsArray) {
      albums.add(Album.fromMap(album));
    }
  }
}
