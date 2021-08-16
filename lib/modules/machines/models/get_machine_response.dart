// Project imports:

import 'package:bitecope/modules/machines/models/machine.dart';

class GetMachinesResponse {
  bool status;
  List<Machine>? machines;

  GetMachinesResponse({
    this.status = false,
    this.machines,
  }) {
    machines?.sort((a, b) => a.name.compareTo(b.name));
  }

  factory GetMachinesResponse.fromMap(Map<String, dynamic> map) {
    return GetMachinesResponse(
      status: map['statusCode'] as int < 300,
      machines: map['list'] == null
          ? null
          : List<Machine>.from(
              (map['list'] as List).map(
                (_machine) => Machine.fromMap(_machine as Map<String, dynamic>),
              ),
            ),
    );
  }
}
