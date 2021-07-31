// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class SignInResponseModel {
  bool status;
  String? expiresIn;
  String? token;
  String? error;

  SignInResponseModel({
    this.status = false,
    this.expiresIn,
    this.token,
    this.error,
  });

  factory SignInResponseModel.fromMap(Map<String, dynamic> map) {
    return SignInResponseModel(
      status: map['statusCode'] as int < 300,
      token: map['Token'] != null ? map['Token'] as String : null,
      expiresIn: map['Expires_in'] != null ? map['Expires_in'] as String : null,
      error: map['statusCode'] as int >= 400 ? map.getMessage() : null,
    );
  }

  factory SignInResponseModel.fromJson(String source) =>
      SignInResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
