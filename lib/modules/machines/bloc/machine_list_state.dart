part of 'machine_list_bloc.dart';

class MachineListState with EquatableMixin {
  List<Machine>? machines;
  MachineListStatus machineListStatus;

  MachineListState({
    this.machines,
    this.machineListStatus = MachineListStatus.loading,
  });

  @override
  List<Object?> get props => [machines, machineListStatus];

  MachineListState copyWith({
    List<Machine>? machines,
    MachineListStatus? machineListStatus,
  }) {
    return MachineListState(
      machines: machines ?? this.machines,
      machineListStatus: machineListStatus ?? this.machineListStatus,
    );
  }
}

enum MachineListStatus {
  loading,
  ready,
  failed,
}
