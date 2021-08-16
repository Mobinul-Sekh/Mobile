class DeleteMachineRequest {
  String machineID;

  DeleteMachineRequest({
    required this.machineID,
  });

  Map<String, dynamic> toMap() {
    return {
      'machine_id': machineID,
    };
  }
}
