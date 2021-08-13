part of 'worker_list_bloc.dart';

class WorkerListState with EquatableMixin {
  List<Worker>? workers;
  WorkerListStatus workerListStatus;

  WorkerListState({
    this.workers,
    this.workerListStatus = WorkerListStatus.loading,
  });

  @override
  List<Object?> get props => [workers, workerListStatus];

  WorkerListState copyWith({
    List<Worker>? workers,
    WorkerListStatus? workerListStatus,
  }) {
    return WorkerListState(
      workers: workers ?? this.workers,
      workerListStatus: workerListStatus ?? this.workerListStatus,
    );
  }
}

enum WorkerListStatus {
  loading,
  ready,
  failed,
}
