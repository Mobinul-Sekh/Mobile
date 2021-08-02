// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/core/common/components/listing_tile_data.dart';
import 'package:bitecope/modules/suppliers/screens/view_supplier.dart';

class Supplier implements ListingTile {
  String id;
  String name;
  String phoneNumber;
  String address;
  String? description;

  @override
  String get text => name;

  @override
  Route? get route => MaterialPageRoute(
        builder: (context) => ViewSupplier(supplier: this),
      );

  Supplier({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    this.description,
  });

  Supplier copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? address,
    String? description,
  }) {
    return Supplier(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'supplier_id': id,
      'supplier_name': name,
      'phone_no': phoneNumber,
      'address': address,
      'description': description,
    };
  }

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: (map['supplier_id'] as int).toString(),
      name: map['supplier_name'] as String,
      phoneNumber: (map['phone_no'] as int).toString(),
      address: map['address'] as String,
      description: map['description'] as String?,
    );
  }
}
