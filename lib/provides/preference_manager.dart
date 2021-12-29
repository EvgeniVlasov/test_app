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

  static const String _USERS_KEY = '_USERS_KEY';
  static const String _POSTS_KEY = '_POSTS_KEY';
  static const String _ALBUMS_KEY = '_ALBUMS_KEY';
  static const String _COMMENTS_KEY = '_COMMENTS_KEY';
  static const String _PHOTOS_KEY = '_PHOTOS_KEY';

  Future getUsers() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_USERS_KEY) != null) {
      var usersPref = prefs.getString(_USERS_KEY);
      return UsersResponse.fromMap(jsonDecode(usersPref!));
    }
    return null;
  }

  Future<bool> saveUsers(String users) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_USERS_KEY, users);
    return true;
  }

  Future getPosts() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_POSTS_KEY) != null) {
      var postsPref = prefs.getString(_POSTS_KEY);
      return PostsResponse.fromMap(jsonDecode(postsPref!));
    }
    return null;
  }

  Future<bool> savePosts(String posts) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_POSTS_KEY, posts);
    return true;
  }

  Future getAlbums() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_ALBUMS_KEY) != null) {
      var albumsPref = prefs.getString(_ALBUMS_KEY);
      return AlbumsResponse.fromMap(jsonDecode(albumsPref!));
    }
    return null;
  }

  Future<bool> saveAlbums(String albums) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_ALBUMS_KEY, albums);
    return true;
  }

  Future getComments() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_COMMENTS_KEY) != null) {
      var commentsPref = prefs.getString(_COMMENTS_KEY);
      return CommentsResponse.fromMap(jsonDecode(commentsPref!));
    }
    return null;
  }

  Future<bool> saveComments(String comments) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_COMMENTS_KEY, comments);
    return true;
  }

  Future getPhotos() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_PHOTOS_KEY) != null) {
      var photosPref = prefs.getString(_PHOTOS_KEY);
      return PhotosResponse.fromMap(jsonDecode(photosPref!));
    }
    return null;
  }

  Future<bool> savePhotos(String photos) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString(_PHOTOS_KEY, photos);
    return true;
  }
}
