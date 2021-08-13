// Package imports:
import 'package:bitecope/config/utils/typedefs.dart';
import 'package:bitecope/modules/workers/bloc/worker_list_bloc.dart';
import 'package:bitecope/modules/workers/models/delete_worker_response.dart';
import 'package:bitecope/modules/workers/repositories/worker_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'worker_state.dart';

class WorkerBloc extends Cubit<WorkerState> {
  final WorkerListBloc _workerListBloc;
  late final WorkerRepository _workerRepository;

  WorkerBloc(this._workerListBloc) : super(WorkerState()) {
    _workerRepository = _workerListBloc.repository;
  }

  void confirmDelete({
    required String workerName,
  }) {
    emit(state.copyWith(
      name: workerName,
      workerStatus: WorkerStatus.deleteValidated,
    ));
    emit(state.copyWith(
      workerStatus: WorkerStatus.confirmDelete,
    ));
  }

  Future<void> deleteWorker() async {
    emit(state.copyWith(workerStatus: WorkerStatus.loading));

    final DeleteWorkerResponse? _response =
        await _workerRepository.deleteWorker(
      workerName: state.name!,
    );

    if (_response != null) {
      if (_response.status) {
        _workerListBloc.deleteWorker(
          workerName: state.name!,
        );
        emit(state.copyWith(
          workerStatus: WorkerStatus.done,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) => _response.message,
          workerStatus: WorkerStatus.ready,
        ));
      }
    }
  }
}
