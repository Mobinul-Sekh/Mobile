// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class AddWarehouseResponse {
  bool status;
  String? warehouseNameError;

  String? descriptionError;
  String? otherError;

  AddWarehouseResponse({
    this.status = false,
    this.warehouseNameError,
    this.descriptionError,
    this.otherError,
  });

  factory AddWarehouseResponse.fromMap(Map<String, dynamic> map) {
    return AddWarehouseResponse(
      status: map['statusCode'] as int < 300,
      warehouseNameError: map['location_name'] != null
          ? map['location_name'][0] as String
          : null,
      descriptionError:
          map['description'] != null ? map['description'][0] as String : null,
      otherError: map.getMessage(
        ignoreKeys: [
          "location_name",
          "description",
        ],
      ),
    );
  }
}
