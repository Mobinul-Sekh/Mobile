// Dart imports:
import 'dart:convert';

class VerifyEmailResponse {
  String? status;

  VerifyEmailResponse({this.status});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
    };
  }

  factory VerifyEmailResponse.fromMap(Map<String, dynamic> map) {
    return VerifyEmailResponse(
      status: map.values.isNotEmpty ? map.values.toList()[0] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyEmailResponse.fromJson(String source) =>
      VerifyEmailResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
