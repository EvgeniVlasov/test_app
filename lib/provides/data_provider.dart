import 'package:flutter/material.dart';
import 'package:flutter_test_app_eclipse/api/api_service.dart';
import 'package:flutter_test_app_eclipse/api/models/album.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/albums_reponse.dart';
import 'package:flutter_test_app_eclipse/api/models/comment.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/comments_response.dart';
import 'package:flutter_test_app_eclipse/api/models/photo.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/photos_response.dart';
import 'package:flutter_test_app_eclipse/api/models/post.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/posts_response.dart';
import 'package:flutter_test_app_eclipse/api/models/user.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/users_response.dart';
import 'package:flutter_test_app_eclipse/provides/preference_manager.dart';

class DataProvider extends ChangeNotifier {
  final GatewayService _gatewayService = GatewayService();
  List<User> allUsers = [];
  List<Post> allPosts = [];
  List<Album> allAlbums = [];
  List<Photo> allPhotos = [];
  List<Comment> allComments = [];
  List<Post> previewPostsCurrentUser = [];
  List<Album> previewAlbumsCurrentUser = [];
  List<Post> postsCurrentUser = [];
  List<Album> albumsCurrentUser = [];
  List<Photo> photosCurrentAlbum = [];
  List<Comment> commentsCurrentPost = [];
  List<Photo> previewPhotoForAlbumsCurrentUser = [];

  User currentUser = User();
  Album currentAlbum = Album();
  Post currentPost = Post();
  Comment currentComment = Comment();

  Future getUsers() async {
    if (await PreferenceManager().getUsers() != null) {
      UsersResponse userPref = await PreferenceManager().getUsers();
      allUsers = userPref.users;
    } else {
      UsersResponse response = await _gatewayService.getUsers();
      allUsers = response.users;
    }
  }

  Future getPosts() async {
    if (await PreferenceManager().getPosts() != null) {
      PostsResponse postsPref = await PreferenceManager().getPosts();
      allPosts = postsPref.posts;
    } else {
      PostsResponse response = await _gatewayService.getPosts();
      allPosts = response.posts;
    }
  }

  Future getAlbums() async {
    if (await PreferenceManager().getAlbums() != null) {
      AlbumsResponse albumsPref = await PreferenceManager().getAlbums();
      allAlbums = albumsPref.albums;
    } else {
      AlbumsResponse response = await _gatewayService.getAlbums();
      allAlbums = response.albums;
    }
  }

  Future getPhotos() async {
    if (await PreferenceManager().getPhotos() != null) {
      PhotosResponse photosPref = await PreferenceManager().getPhotos();
      allPhotos = photosPref.photos;
    } else {
      PhotosResponse response = await _gatewayService.getPhotos();
      allPhotos = response.photos;
    }
  }

  Future getComments() async {
    if (await PreferenceManager().getComments() != null) {
      CommentsResponse commentsPref = await PreferenceManager().getComments();
      allComments = commentsPref.comments;
    } else {
      CommentsResponse response = await _gatewayService.getComments();
      allComments = response.comments;
    }
  }

  void getCurrentUser(int userId) {
    for (var user in allUsers) {
      if (userId == user.id) {
        currentUser = user;
      }
    }
  }

  void getPostsCurrentUser() {
    postsCurrentUser = [];
    for (var post in allPosts) {
      if (post.userId == currentUser.id) {
        postsCurrentUser.add(post);
      }
    }
  }

  void getAlbumsCurrentUser() {
    albumsCurrentUser = [];
    for (var album in allAlbums) {
      if (album.userId == currentUser.id) {
        albumsCurrentUser.add(album);
      }
    }
  }

  void getPreviewPostCurrentUser() {
    previewPostsCurrentUser = [];
    for (var i = 0; i < 3; i++) {
      previewPostsCurrentUser.add(postsCurrentUser[i]);
    }
  }

  void getPreviewAlbumsCurrentUser() {
    previewAlbumsCurrentUser = [];
    for (var i = 0; i < 3; i++) {
      previewAlbumsCurrentUser.add(albumsCurrentUser[i]);
    }
  }

  void getCurrentAlbum(int albumId) {
    for (var album in albumsCurrentUser) {
      if (album.id == albumId) {
        currentAlbum = album;
      }
    }
  }

  void getPhotosCurrentAlbum() {
    photosCurrentAlbum = [];
    for (var photo in allPhotos) {
      if (photo.albumId == currentAlbum.id) {
        photosCurrentAlbum.add(photo);
      }
    }
  }

  void getCommentCurrentPost() {
    commentsCurrentPost = [];
    for (var comment in allComments) {
      if (comment.postId == currentPost.id) {
        commentsCurrentPost.add(comment);
      }
    }
  }
  void getCurrentPost(int postId) {
    for (var post in postsCurrentUser) {
      if (post.id == postId) {
        currentPost = post;
      }
    }
  }

// void getPreviewPhotosForAlbumsCurrentUser() {
//   for (int i = 0; i < 3; i++) {
//     previewPhotoForAlbumsCurrentUser.add()
//   }
// }
}
