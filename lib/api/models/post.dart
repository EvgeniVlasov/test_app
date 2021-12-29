class Post {
  late int id;
  int? userId;
  String? title;
  String? body;

  Post();

  Post.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    userId = map['userId'];
    title = map['title'];
    body = map['body'];
  }
}
