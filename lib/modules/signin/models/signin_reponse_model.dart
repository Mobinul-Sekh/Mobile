// Dart imports:
import 'dart:convert';

class SignInResponseModel {
  String? expiresIn;
  String? token;
  String? error;

  SignInResponseModel({
    this.expiresIn,
    this.token,
    this.error,
  });

  factory SignInResponseModel.fromMap(Map<String, dynamic> map) {
    return SignInResponseModel(
      token: map['Token'] != null ? map['Token'] as String : null,
      expiresIn: map['Expires_in'] != null ? map['Expires_in'] as String : null,
      error: map['Error'] != null ? map['Error'] as String : null,
    );
  }

  factory SignInResponseModel.fromJson(String source) =>
      SignInResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
