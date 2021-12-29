class Comment {
  int? postId;
  late int id;
  String? name;
  String? email;
  String? body;

  Comment();

  Comment.fromMap(Map<String, dynamic> map) {
    postId = map['postId'];
    id = map['id'];
    name = map['name'];
    email = map['email'];
    body = map['body'];
  }
}
