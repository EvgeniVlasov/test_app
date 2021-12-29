class SendCommentResponse {
  late int id;
  String? postId;
  String? mail;
  String? name;
  String? body;

  SendCommentResponse();

  SendCommentResponse.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    postId = map['postId'];
    mail = map['mail'];
    name = map['name'];
    body = map['body'];
  }
}
