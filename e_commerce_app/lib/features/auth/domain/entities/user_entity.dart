class UserEntity {
  final String _email;
  final String _password;
  final String _accestoken;
  final String _id;
  final String _name;

  UserEntity(
      {required String email,
      required String password,
      required String id,
      required String accestoken,
      required String name})
      : _email = email,
        _password = password,
        _accestoken = accestoken,
        _id = id,
        _name = name;
}
