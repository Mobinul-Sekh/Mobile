part of 'worker_bloc.dart';

class WorkerState with EquatableMixin {
  late final String? name;
  LocaleString? error;
  WorkerStatus workerStatus;

  WorkerState({
    this.name,
    this.error,
    this.workerStatus = WorkerStatus.ready,
  });

  @override
  List<Object?> get props => [name, error, workerStatus];

  WorkerState copyWith({
    String? name,
    LocaleString? error,
    WorkerStatus? workerStatus,
  }) {
    return WorkerState(
      name: name ?? this.name,
      error: error ?? this.error,
      workerStatus: workerStatus ?? this.workerStatus,
    );
  }
}

enum WorkerStatus {
  ready,
  deleteValidated,
  confirmDelete,
  loading,
  done,
}
