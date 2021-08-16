// Flutter imports:

import 'package:bitecope/modules/machines/models/add_machine_response.dart';
import 'package:bitecope/modules/machines/models/delete_machine_response.dart';
import 'package:bitecope/modules/machines/repositories/machine_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';

import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

import 'machine_list_bloc.dart';

part 'machine_state.dart';

class MachineBloc extends Cubit<MachineState> {
  final MachineListBloc _machineListBloc;
  late final MachineRepository _machineRepository;

  MachineBloc(this._machineListBloc) : super(MachineState()) {
    _machineRepository = _machineListBloc.repository;
  }

  void validateMachine({
    String? name,
  }) {
    final String? _name = name?.trim();

    final Map<String, LocaleString?> _errors = {
      "name": _validateName(_name),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(
      MachineState(
        name: BlocFormField(_name, _errors['name']),
        machineStatus:
            _isValid ? MachineStatus.createValidated : MachineStatus.ready,
      ),
    );

    if (_isValid) {
      emit(state.copyWith(machineStatus: MachineStatus.confirmCreate));
    }
  }

  Future<void> addMachine() async {
    emit(state.copyWith(machineStatus: MachineStatus.loading));

    final AddMachineResponse? _response = await _machineRepository.addMachine(
      name: state.name.value!,
    );

    if (_response != null) {
      if (_response.status) {
        emit(state.copyWith(
          machineStatus: MachineStatus.done,
        ));
      } else {
        emit(state.copyWith(
          name: state.name.copyWith(
            error: _response.machineNameError != null
                ? (BuildContext context) => _response.machineNameError
                : null,
          ),
          error: _response.otherError != null
              ? (BuildContext context) => _response.otherError
              : null,
          machineStatus: MachineStatus.ready,
        ));
      }
    }
  }

  void confirmDelete({
    required String machineID,
  }) {
    emit(state.copyWith(
      id: machineID,
      machineStatus: MachineStatus.deleteValidated,
    ));
    emit(state.copyWith(
      machineStatus: MachineStatus.confirmDelete,
    ));
  }

  Future<void> deleteMachine() async {
    emit(state.copyWith(machineStatus: MachineStatus.loading));

    final DeleteMachineResponse? _response =
        await _machineRepository.deleteMachine(
      machineID: state.id!,
    );

    if (_response != null) {
      if (_response.status) {
        _machineListBloc.deleteMachine(
          machineID: state.id!,
        );
        emit(state.copyWith(
          machineStatus: MachineStatus.done,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) => _response.message,
          machineStatus: MachineStatus.ready,
        ));
      }
    }
  }

  LocaleString? _validateName(String? name) {
    if (name == null || name == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.machineNameEmpty;
    }
    return null;
  }
}
