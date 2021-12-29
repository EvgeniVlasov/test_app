import 'package:flutter_test_app_eclipse/api/models/post.dart';

class PostsResponse{
  List<Post> posts =[];

  PostsResponse.fromMap(List resp){
    List postsArray = List.castFrom(resp);
    for (var post in postsArray) {
      posts.add(Post.fromMap(post));
    }
  }
}