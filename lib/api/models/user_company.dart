class UserCompany {
  late String name;
  late String catchPhrase;
  late String bs;

  UserCompany();

  UserCompany.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    catchPhrase = map['catchPhrase'];
    bs = map['bs'];
  }
}
