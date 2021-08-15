// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class VerifyEmailResponse {
  bool status;
  String? message;

  VerifyEmailResponse({
    this.status = false,
    this.message,
  });

  factory VerifyEmailResponse.fromMap(Map<String, dynamic> map) {
    return VerifyEmailResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
