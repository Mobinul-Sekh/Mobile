part of 'machine_bloc.dart';

class MachineState with EquatableMixin {
  late final String? id;
  late final BlocFormField<String> name;
  LocaleString? error;
  MachineStatus machineStatus;

  MachineState({
    this.id,
    BlocFormField<String>? name,
    this.error,
    this.machineStatus = MachineStatus.ready,
  }) {
    this.name = name ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        error,
        machineStatus,
      ];

  MachineState copyWith({
    String? id,
    BlocFormField<String>? name,
    LocaleString? error,
    MachineStatus? machineStatus,
  }) {
    return MachineState(
      id: id ?? this.id,
      name: name ?? this.name,
      error: error ?? this.error,
      machineStatus: machineStatus ?? this.machineStatus,
    );
  }
}

enum MachineStatus {
  ready,
  createValidated,
  editValidated,
  deleteValidated,
  confirmCreate,
  confirmEdit,
  confirmDelete,
  loading,
  done,
}
