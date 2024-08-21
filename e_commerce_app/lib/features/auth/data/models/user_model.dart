import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String email;
  final String password;
  final String id;
  final String accestoken;
  final String name;
  UserModel(
      {required this.email,
      required this.password,
      required this.id,
      required this.accestoken,
      required this.name})
      : super(
            email: email,
            password: password,
            id: id,
            accestoken: accestoken,
            name: name);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'],
      password: '',
      id: json['_id'],
      accestoken: '',
      name: json['name']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'access_token': accestoken,
        'id': id
      };
}
