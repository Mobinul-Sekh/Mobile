// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class DeviceDetailsResponse {
  bool status;
  String? message;

  DeviceDetailsResponse({
    this.status = false,
    this.message,
  });

  factory DeviceDetailsResponse.fromMap(Map<String, dynamic> map) {
    return DeviceDetailsResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
