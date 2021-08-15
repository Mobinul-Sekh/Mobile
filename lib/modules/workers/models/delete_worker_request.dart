class DeleteWorkerRequest {
  String workerName;

  DeleteWorkerRequest({
    required this.workerName,
  });

  Map<String, dynamic> toMap() {
    return {
      'worker_name': workerName,
    };
  }
}
