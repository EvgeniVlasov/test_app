import 'dart:convert';

import 'package:flutter_test_app_eclipse/api/models/responses/albums_reponse.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/comments_response.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/photos_response.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/posts_response.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/users_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static final PreferenceManager _singleton = PreferenceManager._internal();

  factory PreferenceManager() {
    return _singleton;
  }

  PreferenceManager._internal();

  static const String _userKey = '_userKey';
  static const String _postsKey = '_postsKey';
  static const String _albumsKey = '_albumsKey';
  static const String _commentsKey = '_commentsKey';
  static const String _photosKey = '_photosKey';

  Future getUsers() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_userKey) != null) {
      var usersPref = prefs.getString(_userKey);
      return UsersResponse.fromMap(jsonDecode(usersPref!));
    }
    return null;
  }

  Future<bool> saveUsers(String users) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, users);
    return true;
  }

  Future getPosts() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_postsKey) != null) {
      var postsPref = prefs.getString(_postsKey);
      return PostsResponse.fromMap(jsonDecode(postsPref!));
    }
    return null;
  }

  Future<bool> savePosts(String posts) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_postsKey, posts);
    return true;
  }

  Future getAlbums() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_albumsKey) != null) {
      var albumsPref = prefs.getString(_albumsKey);
      return AlbumsResponse.fromMap(jsonDecode(albumsPref!));
    }
    return null;
  }

  Future<bool> saveAlbums(String albums) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_albumsKey, albums);
    return true;
  }

  Future getComments() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_commentsKey) != null) {
      var commentsPref = prefs.getString(_commentsKey);
      return CommentsResponse.fromMap(jsonDecode(commentsPref!));
    }
    return null;
  }

  Future<bool> saveComments(String comments) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_commentsKey, comments);
    return true;
  }

  Future getPhotos() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_photosKey) != null) {
      var photosPref = prefs.getString(_photosKey);
      return PhotosResponse.fromMap(jsonDecode(photosPref!));
    }
    return null;
  }

  Future<bool> savePhotos(String photos) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_photosKey, photos);
    return true;
  }
}
