class AddMachineRequest {
  String name;

  AddMachineRequest({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'machine_name': name,
    };
  }
}
