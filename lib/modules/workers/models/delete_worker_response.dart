// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class DeleteWorkerResponse {
  bool status;
  String? message;

  DeleteWorkerResponse({
    this.status = false,
    this.message,
  });

  factory DeleteWorkerResponse.fromMap(Map<String, dynamic> map) {
    return DeleteWorkerResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
