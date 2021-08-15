// Project imports:
import 'package:bitecope/config/utils/extensions/map_extension.dart';

class AddBuyerResponse {
  bool status;
  String? buyerNameError;
  String? phoneNumberError;
  String? addressError;
  String? descriptionError;
  String? otherError;

  AddBuyerResponse({
    this.status = false,
    this.buyerNameError,
    this.phoneNumberError,
    this.addressError,
    this.descriptionError,
    this.otherError,
  });

  factory AddBuyerResponse.fromMap(Map<String, dynamic> map) {
    return AddBuyerResponse(
      status: map['statusCode'] as int < 300,
      buyerNameError:
          map['buyer_name'] != null ? map['buyer_name'][0] as String : null,
      phoneNumberError:
          map['phone_no'] != null ? map['phone_no'][0] as String : null,
      addressError: map['address'] != null ? map['address'][0] as String : null,
      descriptionError:
          map['description'] != null ? map['description'][0] as String : null,
      otherError: map.getMessage(
        ignoreKeys: [
          "buyer_name",
          "phone_no",
          "address",
          "description",
        ],
      ),
    );
  }
}
