// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class EditSupplierResponse {
  bool status;
  String? message;

  EditSupplierResponse({
    this.status = false,
    this.message,
  });

  factory EditSupplierResponse.fromMap(Map<String, dynamic> map) {
    return EditSupplierResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
