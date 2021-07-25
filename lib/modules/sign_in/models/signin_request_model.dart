class SignInRequestModel {
  String username;
  String password;

  SignInRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toDatabaseJson() =>
      {"username": username, "password": password};
}
