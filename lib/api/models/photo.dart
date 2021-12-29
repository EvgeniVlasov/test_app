class Photo {
  int? albumId;
  late int id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo.fromMap(Map<String,dynamic> map){
    albumId = map['albumId'];
    id = map['id'];
    title = map['title'];
    url = map['url'];
    thumbnailUrl = map['thumbnailUrl'];
  }
}
//{
//         "albumId": 1,
//         "id": 1,
//         "title": "accusamus beatae ad facilis cum similique qui sunt",
//         "url": "https://via.placeholder.com/600/92c952",
//         "thumbnailUrl": "https://via.placeholder.com/150/92c952"
//     }