// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class AddSupplierResponse {
  bool status;
  String? supplierNameError;
  String? phoneNumberError;
  String? addressError;
  String? descriptionError;
  String? otherError;

  AddSupplierResponse({
    this.status = false,
    this.supplierNameError,
    this.phoneNumberError,
    this.addressError,
    this.descriptionError,
    this.otherError,
  });

  factory AddSupplierResponse.fromMap(Map<String, dynamic> map) {
    return AddSupplierResponse(
      status: map['statusCode'] as int < 300,
      supplierNameError: map['supplier_name'] != null
          ? map['supplier_name'][0] as String
          : null,
      phoneNumberError:
          map['phone_no'] != null ? map['phone_no'][0] as String : null,
      addressError: map['address'] != null ? map['address'][0] as String : null,
      descriptionError:
          map['description'] != null ? map['description'][0] as String : null,
      otherError: map.getMessage(
        ignoreKeys: [
          "supplier_name",
          "phone_no",
          "address",
          "description",
        ],
      ),
    );
  }
}
