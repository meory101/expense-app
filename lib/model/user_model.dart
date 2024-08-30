class UserModel {

  late String name;
  late String email;
  late String phone;
  late String userArea;

  UserModel();

  UserModel.fromMap(Map<String, dynamic> map) {
    name = map['username'];
    email = map['email'];
    phone = map['phone'];
    userArea = map['userArea'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['username'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['userArea'] = userArea;
    return map;
  }
}