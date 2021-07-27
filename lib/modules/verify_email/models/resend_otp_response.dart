// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class ResendOTPResponse {
  bool status;
  String? message;

  ResendOTPResponse({
    this.status = false,
    this.message,
  });

  factory ResendOTPResponse.fromMap(Map<String, dynamic> map) {
    return ResendOTPResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
