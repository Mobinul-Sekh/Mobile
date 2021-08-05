class AddSupplierRequest {
  String name;
  String phoneNumber;
  String address;
  String? description;

  AddSupplierRequest({
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'supplier_name': name,
      'phone_no': phoneNumber,
      'address': address,
      'description': description,
    };
  }
}
