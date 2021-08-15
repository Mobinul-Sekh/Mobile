// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/worker_initialize/models/worker_initialize_request.dart';
import 'package:bitecope/modules/worker_initialize/models/worker_initialize_response.dart';
import 'package:bitecope/modules/worker_initialize/providers/worker_initialize_provider.dart';

class WorkerInitializeRepository extends CommonRepository {
  final WorkerInitializeProvider _workerInitializeProvider =
      WorkerInitializeProvider();

  Future<WorkerInitializeResponse?> insertWorker({
    required String ownerUsername,
    required String workerName,
    required String workerAddress,
    String? workerDescription,
  }) async {
    final WorkerInitializeRequest request = WorkerInitializeRequest(
      ownerUsername: ownerUsername,
      workerName: workerName,
      workerAddress: workerAddress,
      workerDescription: workerDescription,
    );
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final Map<String, dynamic>? responseMap =
        await _workerInitializeProvider.insertWorker(
      request,
      _authToken,
    );

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final WorkerInitializeResponse response =
        WorkerInitializeResponse.fromMap(responseMap);
    return response;
  }
}
