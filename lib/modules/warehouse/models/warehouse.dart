class Warehouse {
  String id;
  String name;
  String? description;

  Warehouse({
    required this.id,
    required this.name,
    this.description,
  });

  Warehouse copyWith({
    String? id,
    String? name,
    String? description,
  }) {
    return Warehouse(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location_id': id,
      'location_name': name,
      'description': description,
    };
  }

  factory Warehouse.fromMap(Map<String, dynamic> map) {
    return Warehouse(
      id: (map['location_id'] as int).toString(),
      name: map['location_name'] as String,
      description: map['description'] as String?,
    );
  }
}
