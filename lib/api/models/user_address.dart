import 'package:flutter_test_app_eclipse/api/models/address_geo.dart';

class UserAddress {
  late String street;
  late String suite;
  late String city;
  late String zipCode;
  late AddressGeo geo;

  UserAddress();

  UserAddress.fromMap(Map<String, dynamic> map) {
    street = map['street'];
    suite = map['suite'];
    city = map['city'];
    zipCode = map['zipcode'];
    geo = AddressGeo.fromMap(map['geo']);
  }
}
