// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class DeleteBuyerResponse {
  bool status;
  String? message;

  DeleteBuyerResponse({
    this.status = false,
    this.message,
  });

  factory DeleteBuyerResponse.fromMap(Map<String, dynamic> map) {
    return DeleteBuyerResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
