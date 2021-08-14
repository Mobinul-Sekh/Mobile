// Project imports:
import 'package:bitecope/modules/workers/models/worker.dart';

class GetWorkersResponse {
  bool status;
  List<Worker>? workers;

  GetWorkersResponse({
    this.status = false,
    this.workers,
  }) {
    workers?.sort((a, b) => a.name.compareTo(b.name));
  }

  factory GetWorkersResponse.fromMap(Map<String, dynamic> map) {
    return GetWorkersResponse(
      status: map['statusCode'] as int < 300,
      workers: map['list'] == null
          ? null
          : List<Worker>.from(
              (map['list'] as List).map(
                (_supplier) =>
                    Worker.fromMap(_supplier as Map<String, dynamic>),
              ),
            ),
    );
  }
}
