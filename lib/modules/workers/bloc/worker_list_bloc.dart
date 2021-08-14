// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/workers/models/get_workers_response.dart';
import 'package:bitecope/modules/workers/models/worker.dart';
import 'package:bitecope/modules/workers/repositories/worker_repository.dart';

part 'worker_list_state.dart';

class WorkerListBloc extends Cubit<WorkerListState> {
  final WorkerRepository _workerRepository;

  WorkerRepository get repository => _workerRepository;

  WorkerListBloc(this._workerRepository) : super(WorkerListState()) {
    _init();
  }

  Future<void> _init() async {
    final GetWorkersResponse? _response = await _workerRepository.getWorkers();
    if (_response == null || !_response.status) {
      emit(state.copyWith(
        workerListStatus: WorkerListStatus.failed,
      ));
      return;
    }
    emit(state.copyWith(
      workers: _response.workers,
      workerListStatus: WorkerListStatus.ready,
    ));
  }

  void deleteWorker({
    required String workerName,
  }) {
    emit(state.copyWith(workerListStatus: WorkerListStatus.loading));
    final int? _workerIndex =
        state.workers?.indexWhere((_worker) => _worker.name == workerName);
    if (_workerIndex != null) {
      final List<Worker> _updatedWorkers = state.workers!;
      _updatedWorkers.removeAt(_workerIndex);
      emit(state.copyWith(
        workers: _updatedWorkers,
      ));
    }
    emit(state.copyWith(workerListStatus: WorkerListStatus.ready));
  }
}
