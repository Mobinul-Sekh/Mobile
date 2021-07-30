// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class WorkerInitializeResponse {
  bool status;
  String? message;

  WorkerInitializeResponse({
    this.status = false,
    this.message,
  });

  factory WorkerInitializeResponse.fromMap(Map<String, dynamic> map) {
    return WorkerInitializeResponse(
      status: map['statusCode'] as int < 300,
      message: map.getMessage(),
    );
  }
}
