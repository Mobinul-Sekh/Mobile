// Flutter imports:

import 'package:bitecope/modules/warehouse/models/add_warehouse_response.dart';
import 'package:bitecope/modules/warehouse/models/delete_warehouse_response.dart';
import 'package:bitecope/modules/warehouse/repositories/warehouse_repository.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:bitecope/config/utils/typedefs.dart';

import 'package:bitecope/utils/bloc_utils/bloc_form_field.dart';

import 'warehouse_list_bloc.dart';

part 'warehouse_state.dart';

class WarehouseBloc extends Cubit<WarehouseState> {
  final WarehouseListBloc _warehouseListBloc;
  late final WarehouseRepository _warehouseRepository;

  WarehouseBloc(this._warehouseListBloc) : super(WarehouseState()) {
    _warehouseRepository = _warehouseListBloc.repository;
  }

  void validateWarehouse({
    String? name,
    String? description,
  }) {
    final String? _name = name?.trim();

    //! For description, we should either send null or a non-empty string;
    //!   if we send empty string, API returns error.
    final String? _description =
        description?.trim() == "" ? null : description?.trim();

    final Map<String, LocaleString?> _errors = {
      "name": _validateName(_name),
    };

    final bool _isValid = !_errors.values.any((_error) => _error != null);

    emit(
      WarehouseState(
        name: BlocFormField(_name, _errors['name']),
        description: BlocFormField(_description),
        warehouseStatus:
            _isValid ? WarehouseStatus.createValidated : WarehouseStatus.ready,
      ),
    );

    if (_isValid) {
      emit(state.copyWith(warehouseStatus: WarehouseStatus.confirmCreate));
    }
  }

  Future<void> addWarehouse() async {
    emit(state.copyWith(warehouseStatus: WarehouseStatus.loading));

    final AddWarehouseResponse? _response =
        await _warehouseRepository.addWarehouse(
      name: state.name.value!,
      description: state.description.value,
    );

    if (_response != null) {
      if (_response.status) {
        emit(state.copyWith(
          warehouseStatus: WarehouseStatus.done,
        ));
      } else {
        emit(state.copyWith(
          name: state.name.copyWith(
            error: _response.warehouseNameError != null
                ? (BuildContext context) => _response.warehouseNameError
                : null,
          ),
          description: state.description.copyWith(
            error: _response.descriptionError != null
                ? (BuildContext context) => _response.descriptionError
                : null,
          ),
          error: _response.otherError != null
              ? (BuildContext context) => _response.otherError
              : null,
          warehouseStatus: WarehouseStatus.ready,
        ));
      }
    }
  }

  void confirmDelete({
    required String warehouseID,
  }) {
    emit(state.copyWith(
      id: warehouseID,
      warehouseStatus: WarehouseStatus.deleteValidated,
    ));
    emit(state.copyWith(
      warehouseStatus: WarehouseStatus.confirmDelete,
    ));
  }

  Future<void> deleteWarehouse() async {
    emit(state.copyWith(warehouseStatus: WarehouseStatus.loading));

    final DeleteWarehouseResponse? _response =
        await _warehouseRepository.deleteWarehouse(
      warehouseID: state.id!,
    );

    if (_response != null) {
      if (_response.status) {
        _warehouseListBloc.deleteWarehouse(
          warehouseID: state.id!,
        );
        emit(state.copyWith(
          warehouseStatus: WarehouseStatus.done,
        ));
      } else {
        emit(state.copyWith(
          error: (BuildContext context) => _response.message,
          warehouseStatus: WarehouseStatus.ready,
        ));
      }
    }
  }

  LocaleString? _validateName(String? name) {
    if (name == null || name == "") {
      return (BuildContext context) =>
          AppLocalizations.of(context)!.buyerNameEmpty;
    }
    return null;
  }
}
