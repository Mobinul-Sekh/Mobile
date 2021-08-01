// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class OwnerSubscriptionResponse {
  bool status;
  String? message;

  OwnerSubscriptionResponse({
    this.status = false,
    this.message,
  });

  factory OwnerSubscriptionResponse.fromMap(Map<String, dynamic> map) {
    return OwnerSubscriptionResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
