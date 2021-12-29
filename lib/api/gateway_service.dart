import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/albums_reponse.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/comments_response.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/photos_response.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/posts_response.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/response_send_comment.dart';
import 'package:flutter_test_app_eclipse/api/models/responses/users_response.dart';
import 'package:flutter_test_app_eclipse/provides/preference_manager.dart';
import 'package:http/http.dart' as http;

class GatewayService {
  static final GatewayService _singleton = GatewayService._internal();

  factory GatewayService() {
    return _singleton;
  }

  GatewayService._internal();

  final String _baseUrl = 'jsonplaceholder.typicode.com';
  final String _scheme = 'https';
  final int? _port = null;

  static const String _methodGetUsers = '/users';
  static const String _methodGetPosts = '/posts';
  static const String _methodGetPhotos = '/photos';
  static const String _methodGetAlbums = '/albums';
  static const String _methodGetComment = '/comments';

  Future getUsers() async {
    var response = await getRequest(path: _methodGetUsers);
    PreferenceManager().saveUsers(response!.body);
    return UsersResponse.fromMap(jsonDecode(response.body));
  }

  Future getPosts() async {
    var response = await getRequest(path: _methodGetPosts);
    PreferenceManager().savePosts(response!.body);
    return PostsResponse.fromMap(jsonDecode(response.body));
  }

  Future getAlbums() async {
    var response = await getRequest(path: _methodGetAlbums);
    PreferenceManager().saveAlbums(response!.body);
    return AlbumsResponse.fromMap(jsonDecode(response.body));
  }

  Future getPhotos() async {
    var response = await getRequest(path: _methodGetPhotos);
    PreferenceManager().savePhotos(response!.body);
    return PhotosResponse.fromMap(jsonDecode(response.body));
  }

  Future getComments() async {
    var response = await getRequest(path: _methodGetComment);
    PreferenceManager().saveComments(response!.body);
    return CommentsResponse.fromMap(jsonDecode(response.body));
  }

  Future sendCommentForPost(
      {required String mail,
      required String name,
      required String body,
      required int idPost}) async {
    var map = {'mail': mail, 'name': name, 'body': body};
    var bodyJson = jsonEncode(map);
    var response = await postRequest(
        path: _methodGetPosts + '/$idPost' + _methodGetComment, body: bodyJson);
    return SendCommentResponse.fromMap(jsonDecode(response!.body));
  }

  Uri _getUri({required String path, Map<String, dynamic>? params}) {
    return Uri(
      host: _baseUrl,
      scheme: _scheme,
      port: _port,
      path: path,
      queryParameters: params,
    );
  }

  Future<http.Response?> getRequest({
    required String path,
    Map<String, dynamic>? params,
  }) async {
    try {
      var response = await http.get(_getUri(path: path, params: params),
          headers: await headerFormation());
      debugPrint('RESULT PATH: ${response.request}');
      debugPrint('Response: ${response.body}');
      return response;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<http.Response?> postRequest(
      {required String path, required String body}) async {
    try {
      var response = await http.post(_getUri(path: path),
          body: body, headers: await headerFormation());
      debugPrint('RESULT PATH: ${response.request}');
      debugPrint('Response: ${response.body}');
      return response;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  static Future<Map<String, String>> headerFormation() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    debugPrint('HEADERS: $headers');
    return headers;
  }
}
