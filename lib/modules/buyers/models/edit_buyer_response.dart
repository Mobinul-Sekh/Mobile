// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class EditBuyerResponse {
  bool status;
  String? message;

  EditBuyerResponse({
    this.status = false,
    this.message,
  });

  factory EditBuyerResponse.fromMap(Map<String, dynamic> map) {
    return EditBuyerResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
