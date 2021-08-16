// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class DeleteWarehouseResponse {
  bool status;
  String? message;

  DeleteWarehouseResponse({
    this.status = false,
    this.message,
  });

  factory DeleteWarehouseResponse.fromMap(Map<String, dynamic> map) {
    return DeleteWarehouseResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
