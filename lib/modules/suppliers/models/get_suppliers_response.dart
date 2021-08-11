// Project imports:
import 'package:bitecope/modules/suppliers/models/supplier.dart';

class GetSuppliersResponse {
  bool status;
  List<Supplier>? suppliers;

  GetSuppliersResponse({
    this.status = false,
    this.suppliers,
  }) {
    suppliers?.sort((a, b) => a.name.compareTo(b.name));
  }

  factory GetSuppliersResponse.fromMap(Map<String, dynamic> map) {
    return GetSuppliersResponse(
      status: map['statusCode'] as int < 300,
      suppliers: map['list'] == null
          ? null
          : List<Supplier>.from(
              (map['list'] as List).map(
                (_supplier) =>
                    Supplier.fromMap(_supplier as Map<String, dynamic>),
              ),
            ),
    );
  }
}
