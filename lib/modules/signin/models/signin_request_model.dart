import 'package:flutter/cupertino.dart';

class SignInRequestModel {
  late String _username;
  late String _password;

  SignInRequestModel({required String username, required String password}) {
    _username = username;
    _password = password;
  }

  Map<String, dynamic> toDatabaseJson() =>
      {"username": _username, "password": _password};
}
