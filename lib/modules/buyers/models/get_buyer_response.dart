// Project imports:

import 'buyer.dart';

class GetBuyersResponse {
  bool status;
  List<Buyer>? buyers;

  GetBuyersResponse({
    this.status = false,
    this.buyers,
  }) {
    buyers?.sort((a, b) => a.name.compareTo(b.name));
  }

  factory GetBuyersResponse.fromMap(Map<String, dynamic> map) {
    return GetBuyersResponse(
      status: map['statusCode'] as int < 300,
      buyers: map['list'] == null
          ? null
          : List<Buyer>.from(
              (map['list'] as List).map(
                (_buyer) => Buyer.fromMap(_buyer as Map<String, dynamic>),
              ),
            ),
    );
  }
}
