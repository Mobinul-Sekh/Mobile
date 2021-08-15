class AddWarehouseRequest {
  String name;

  String? description;

  AddWarehouseRequest({
    required this.name,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'location_name': name,
      'description': description,
    };
  }
}
