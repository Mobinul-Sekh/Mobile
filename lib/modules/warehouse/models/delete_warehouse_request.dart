class DeleteWarehouseRequest {
  String warehouseID;

  DeleteWarehouseRequest({
    required this.warehouseID,
  });

  Map<String, dynamic> toMap() {
    return {
      'location_id': warehouseID,
    };
  }
}
