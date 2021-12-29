import 'package:flutter_test_app_eclipse/api/models/user.dart';

class UsersResponse {
  List<User> users = [];

  UsersResponse();

  UsersResponse.fromMap(List resp) {
    List userArray = List.castFrom(resp);
    for (var user in userArray) {
      users.add(User.fromMap(user));
    }
  }
}
