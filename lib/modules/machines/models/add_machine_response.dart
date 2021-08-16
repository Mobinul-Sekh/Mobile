// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class AddMachineResponse {
  bool status;
  String? machineNameError;
  String? otherError;

  AddMachineResponse({
    this.status = false,
    this.machineNameError,
    this.otherError,
  });

  factory AddMachineResponse.fromMap(Map<String, dynamic> map) {
    return AddMachineResponse(
      status: map['statusCode'] as int < 300,
      machineNameError:
          map['machine_name'] != null ? map['machine_name'][0] as String : null,
      otherError: map.getMessage(
        ignoreKeys: [
          "machine_name",
        ],
      ),
    );
  }
}
