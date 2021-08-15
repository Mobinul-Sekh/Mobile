class Buyer {
  String id;
  String name;
  String phoneNumber;
  String address;
  String? description;

  Buyer({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.description,
  });

  Buyer copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    return Buyer(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buyer_id': id,
      'buyer_name': name,
      'phone_no': phoneNumber,
      'address': address,
      'description': description,
    };
  }

  factory Buyer.fromMap(Map<String, dynamic> map) {
    return Buyer(
      id: (map['buyer_id'] as int).toString(),
      name: map['buyer_name'] as String,
      phoneNumber: (map['phone_no'] as int).toString(),
      address: map['address'] as String,
      description: map['description'] as String?,
    );
  }
}
