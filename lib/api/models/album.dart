class Album {
  int? userId;
  late int id;
  String? title;

  Album();

  Album.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    id = map['id'];
    title = map['title'];
  }
}
