part of 'worker_initialize_bloc.dart';

class WorkerInitializeState with EquatableMixin {
  late final BlocFormField<String> ownerUsername;
  late final BlocFormField<String> workerName;
  late final BlocFormField<String> workerAddress;
  late final BlocFormField<String> aboutYourself;
  LocaleString? error;
  WorkerInitializeStatus workerInitializeStatus;

  WorkerInitializeState({
    BlocFormField<String>? ownerUsername,
    BlocFormField<String>? workerName,
    BlocFormField<String>? workerAddress,
    BlocFormField<String>? aboutYourself,
    this.error,
    this.workerInitializeStatus = WorkerInitializeStatus.initialize,
  }) {
    this.ownerUsername = ownerUsername ?? BlocFormField<String>();
    this.workerName = workerName ?? BlocFormField<String>();
    this.workerAddress = workerAddress ?? BlocFormField<String>();
    this.aboutYourself = aboutYourself ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        ownerUsername,
        workerName,
        workerAddress,
        aboutYourself,
        error,
        workerInitializeStatus,
      ];

  WorkerInitializeState copyWith({
    BlocFormField<String>? ownerUsername,
    BlocFormField<String>? workerName,
    BlocFormField<String>? workerAddress,
    BlocFormField<String>? aboutYourself,
    LocaleString? error,
    WorkerInitializeStatus? workerInitializeStatus,
  }) {
    return WorkerInitializeState(
      ownerUsername: ownerUsername ?? this.ownerUsername,
      workerName: workerName ?? this.workerName,
      workerAddress: workerAddress ?? this.workerAddress,
      aboutYourself: aboutYourself ?? this.aboutYourself,
      error: error ?? this.error,
      workerInitializeStatus:
          workerInitializeStatus ?? this.workerInitializeStatus,
    );
  }
}

enum WorkerInitializeStatus {
  initialize,
  initializing,
  initialized,
}
