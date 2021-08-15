// Project imports:

import 'warehouse.dart';

class GetWarehousesResponse {
  bool status;
  List<Warehouse>? buyers;

  GetWarehousesResponse({
    this.status = false,
    this.buyers,
  }) {
    buyers?.sort((a, b) => a.name.compareTo(b.name));
  }

  factory GetWarehousesResponse.fromMap(Map<String, dynamic> map) {
    return GetWarehousesResponse(
      status: map['statusCode'] as int < 300,
      buyers: map['list'] == null
          ? null
          : List<Warehouse>.from(
              (map['list'] as List).map(
                (_buyer) => Warehouse.fromMap(_buyer as Map<String, dynamic>),
              ),
            ),
    );
  }
}
