class DeleteSupplierRequest {
  String supplierID;

  DeleteSupplierRequest({
    required this.supplierID,
  });

  Map<String, dynamic> toMap() {
    return {
      'supplier_id': supplierID,
    };
  }
}
