class Machine {
  String id;
  String name;

  Machine({
    required this.id,
    required this.name,
  });

  Machine copyWith({
    String? id,
    String? name,
  }) {
    return Machine(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'machine_id': id,
      'machine_name': name,
    };
  }

  factory Machine.fromMap(Map<String, dynamic> map) {
    return Machine(
      id: (map['machine_id'] as int).toString(),
      name: map['machine_name'] as String,
    );
  }
}
