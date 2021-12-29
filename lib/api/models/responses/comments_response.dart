import 'package:flutter_test_app_eclipse/api/models/comment.dart';

class CommentsResponse {
  List<Comment> comments = [];

  CommentsResponse.fromMap(List resp) {
    List commentsArray = List.castFrom(resp);
    for (var comment in commentsArray) {
      comments.add(Comment.fromMap(comment));
    }
  }
}
