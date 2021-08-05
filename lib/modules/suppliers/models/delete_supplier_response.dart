// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class DeleteSupplierResponse {
  bool status;
  String? message;

  DeleteSupplierResponse({
    this.status = false,
    this.message,
  });

  factory DeleteSupplierResponse.fromMap(Map<String, dynamic> map) {
    return DeleteSupplierResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
