class UserModel {
  String? userId;
  String? email;
  String? phone;
  String? name;

  UserModel({this.userId, this.email, this.phone, this.name});

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    userId = map['userId'];
    email = map['email'];
    phone = map['phone'];
    name = map['name'];
  }

  toJson() {
    return {'name': name, 'userId': userId, 'phone': phone, 'email': email};
  }
}
