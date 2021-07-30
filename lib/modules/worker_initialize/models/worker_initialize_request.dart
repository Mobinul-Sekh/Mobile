class WorkerInitializeRequest {
  String ownerUsername;
  String workerName;
  String workerAddress;
  String? workerDescription;

  WorkerInitializeRequest({
    required this.ownerUsername,
    required this.workerName,
    required this.workerAddress,
    this.workerDescription,
  });

  Map<String, dynamic> toMap() {
    return {
      'owner_name': ownerUsername,
      'worker_name': workerName,
      'address': workerAddress,
      'description': workerDescription,
    };
  }
}
