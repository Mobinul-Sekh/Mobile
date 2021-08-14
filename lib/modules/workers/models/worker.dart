class Worker {
  String id;
  String name;
  String address;
  String? description;

  Worker({
    required this.id,
    required this.name,
    required this.address,
    this.description,
  });

  Worker copyWith({
    String? id,
    String? name,
    String? address,
    String? description,
  }) {
    return Worker(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'description': description,
    };
  }

  factory Worker.fromMap(Map<String, dynamic> map) {
    return Worker(
      id: (map['worker_id'] as int).toString(),
      name: map['worker_name'] as String,
      address: map['address'] as String,
      description: map['description'] as String?,
    );
  }
}
