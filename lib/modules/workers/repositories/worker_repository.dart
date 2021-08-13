// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/workers/models/delete_worker_request.dart';
import 'package:bitecope/modules/workers/models/delete_worker_response.dart';
import 'package:bitecope/modules/workers/models/get_workers_response.dart';
import 'package:bitecope/modules/workers/providers/worker_provider.dart';

class WorkerRepository extends CommonRepository {
  final WorkerProvider _workerProvider = WorkerProvider();

  Future<GetWorkersResponse?> getWorkers() async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final Map<String, dynamic>? _responseMap =
        await _workerProvider.getWorkers(_authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final GetWorkersResponse _response =
        GetWorkersResponse.fromMap(_responseMap);
    return _response;
  }

  Future<DeleteWorkerResponse?> deleteWorker({
    required String workerName,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final DeleteWorkerRequest request = DeleteWorkerRequest(
      workerName: workerName,
    );
    final Map<String, dynamic>? _responseMap =
        await _workerProvider.deleteWorker(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final DeleteWorkerResponse _response =
        DeleteWorkerResponse.fromMap(_responseMap);
    return _response;
  }
}
