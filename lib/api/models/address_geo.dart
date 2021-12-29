class AddressGeo {
  String? lat;
  String? lng;

  AddressGeo();

  AddressGeo.fromMap(Map<String, dynamic> map) {
    lat = map['lat'];
    lng = map['lng'];
  }
}
