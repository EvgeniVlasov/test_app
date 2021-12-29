import 'package:flutter_test_app_eclipse/api/models/user_address.dart';
import 'package:flutter_test_app_eclipse/api/models/user_company.dart';

class User {
  late int id;
  late String name;
  late String userName;
  late String email;
  late String phone;
  late String website;
  late UserAddress userAddress;
  late UserCompany userCompany;

  User();

  User.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? 0;
    name = map['name'] ?? '';
    userName = map['username'] ?? '';
    email = map['email'] ?? '';
    phone = map['phone'] ?? '';
    website = map['website'] ?? '';
    userAddress = UserAddress.fromMap(map['address'] ?? {});
    userCompany = UserCompany.fromMap(map['company'] ?? {});
  }
}
