// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class DeleteMachineResponse {
  bool status;
  String? message;

  DeleteMachineResponse({
    this.status = false,
    this.message,
  });

  factory DeleteMachineResponse.fromMap(Map<String, dynamic> map) {
    return DeleteMachineResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
