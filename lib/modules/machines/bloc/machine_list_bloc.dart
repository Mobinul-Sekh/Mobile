// Package imports:
import 'package:bitecope/modules/machines/models/get_machine_response.dart';
import 'package:bitecope/modules/machines/models/machine.dart';
import 'package:bitecope/modules/machines/repositories/machine_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:

part 'machine_list_state.dart';

class MachineListBloc extends Cubit<MachineListState> {
  final MachineRepository _machineRepository;

  MachineRepository get repository => _machineRepository;

  MachineListBloc(this._machineRepository) : super(MachineListState()) {
    _init();
  }

  Future<void> _init() async {
    final GetMachinesResponse? _response =
        await _machineRepository.getMachines();
    if (_response == null || !_response.status) {
      emit(state.copyWith(
        machineListStatus: MachineListStatus.failed,
      ));
      return;
    }
    emit(state.copyWith(
      machines: _response.machines,
      machineListStatus: MachineListStatus.ready,
    ));
  }

  void deleteMachine({
    required String machineID,
  }) {
    emit(state.copyWith(machineListStatus: MachineListStatus.loading));

    final int? _machineIndex =
        state.machines?.indexWhere((_machine) => _machine.id == machineID);

    if (_machineIndex != null) {
      final List<Machine> _updatedMachines = state.machines!;
      _updatedMachines.removeAt(_machineIndex);

      emit(state.copyWith(
        machines: _updatedMachines,
      ));
    }

    emit(state.copyWith(machineListStatus: MachineListStatus.ready));
  }
}
