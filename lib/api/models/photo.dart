class Photo {
  int? albumId;
  late int id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo.fromMap(Map<String, dynamic> map) {
    albumId = map['albumId'];
    id = map['id'];
    title = map['title'];
    url = map['url'];
    thumbnailUrl = map['thumbnailUrl'];
  }
}
