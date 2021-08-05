class EditSupplierRequest {
  String supplierID;
  String? description;

  EditSupplierRequest({
    required this.supplierID,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'supplier_id': supplierID,
      'description': description,
    };
  }
}
