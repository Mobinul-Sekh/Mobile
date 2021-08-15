// Package imports:

import 'package:bitecope/modules/warehouse/models/get_warehouse_response.dart';
import 'package:bitecope/modules/warehouse/models/warehouse.dart';
import 'package:bitecope/modules/warehouse/repositories/warehouse_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:

part 'warehouse_list_state.dart';

class WarehouseListBloc extends Cubit<WarehouseListState> {
  final WarehouseRepository _warehouseRepository;

  WarehouseRepository get repository => _warehouseRepository;

  WarehouseListBloc(this._warehouseRepository) : super(WarehouseListState()) {
    _init();
  }

  Future<void> _init() async {
    final GetWarehousesResponse? _response =
        await _warehouseRepository.getWarehouses();
    if (_response == null || !_response.status) {
      emit(state.copyWith(
        warehouseListStatus: WarehouseListStatus.failed,
      ));
      return;
    }
    emit(state.copyWith(
      warehouse: _response.buyers,
      warehouseListStatus: WarehouseListStatus.ready,
    ));
  }

  void deleteWarehouse({
    required String warehouseID,
  }) {
    emit(state.copyWith(warehouseListStatus: WarehouseListStatus.loading));
    final int? _warehouseIndex = state.warehouse
        ?.indexWhere((_warehouse) => _warehouse.id == warehouseID);
    if (_warehouseIndex != null) {
      final List<Warehouse> _updatedWarehouses = state.warehouse!;
      _updatedWarehouses.removeAt(_warehouseIndex);
      emit(state.copyWith(
        warehouse: _updatedWarehouses,
      ));
    }
    emit(state.copyWith(warehouseListStatus: WarehouseListStatus.ready));
  }
}
