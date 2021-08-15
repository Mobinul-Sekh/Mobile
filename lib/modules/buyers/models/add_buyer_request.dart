class AddBuyerRequest {
  String name;
  String phoneNumber;
  String address;
  String? description;

  AddBuyerRequest({
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'buyer_name': name,
      'phone_no': phoneNumber,
      'address': address,
      'description': description,
    };
  }
}
