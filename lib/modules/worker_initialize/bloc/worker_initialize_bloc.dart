// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/modules/worker_initialize/models/worker_initialize_response.dart';
import 'package:bitecope/modules/worker_initialize/repositories/worker_initialize_repository.dart';
import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

part 'worker_initialize_state.dart';

class WorkerInitializeBloc extends Cubit<WorkerInitializeState> {
  final WorkerInitializeRepository _workerInitializeRepository;

  WorkerInitializeBloc(this._workerInitializeRepository)
      : super(WorkerInitializeState());

  void validateWorkerInitialize({
    String? ownerUsername,
    String? workerName,
    String? workerAddress,
    String? aboutYourself,
  }) {
    final String? _ownerUsername = ownerUsername?.trim();
    final String? _workerName = workerName?.trim();
    final String? _workerAddress = workerAddress?.trim();
    final String? _aboutYourself = aboutYourself?.trim();

    final Map<String, LocaleString?> _errors = {
      "ownerUsername": _validateOwnerUsername(_ownerUsername),
      "workerName": _validateWorkerName(_workerName),
      "workerAddress": _validateWorkerAddress(_workerAddress),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(state.copyWith(
      ownerUsername: BlocFormField(
        _ownerUsername,
        _errors["ownerUsername"],
      ),
      workerName: BlocFormField(
        _workerName,
        _errors["workerName"],
      ),
      workerAddress: BlocFormField(
        _workerAddress,
        _errors["workerAddress"],
      ),
      aboutYourself: BlocFormField(_aboutYourself),
      workerInitializeStatus: _isValid
          ? WorkerInitializeStatus.initializing
          : WorkerInitializeStatus.initialize,
    ));

    if (_isValid) {
      _insertWorker();
    }
  }

  Future<void> _insertWorker() async {
    final WorkerInitializeResponse? response =
        await _workerInitializeRepository.insertWorker(
      ownerUsername: state.ownerUsername.value!,
      workerName: state.workerName.value!,
      workerAddress: state.workerAddress.value!,
      workerDescription: state.aboutYourself.value,
    );
    if (response != null) {
      if (response.status) {
        emit(state.copyWith(
            workerInitializeStatus: WorkerInitializeStatus.initialized));
      } else {
        _setErrors(response);
      }
    }
  }

  LocaleString? _validateOwnerUsername(String? ownerUsername) {
    if (ownerUsername == null || ownerUsername == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.ownerUsernameEmpty;
    }
    return null;
  }

  LocaleString? _validateWorkerName(String? workerName) {
    if (workerName == null || workerName == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.workerNameEmpty;
    }
    return null;
  }

  LocaleString? _validateWorkerAddress(String? workerAddress) {
    if (workerAddress == null || workerAddress == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.workerAddressEmpty;
    }
    return null;
  }

  void _setErrors(WorkerInitializeResponse response) {
    emit(state.copyWith(
      error: (BuildContext context) => response.message,
      workerInitializeStatus: WorkerInitializeStatus.initialize,
    ));
  }
}
