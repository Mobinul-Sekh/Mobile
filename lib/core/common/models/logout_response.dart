import 'package:bitecope/config/utils/extensions/map_extension.dart';

class LogoutResponse {
  bool status;
  String? message;

  LogoutResponse({
    this.status = false,
    this.message,
  });

  factory LogoutResponse.fromMap(Map<String, dynamic> map) {
    return LogoutResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
