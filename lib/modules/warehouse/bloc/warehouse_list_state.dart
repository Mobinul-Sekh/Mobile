part of 'warehouse_list_bloc.dart';

class WarehouseListState with EquatableMixin {
  List<Warehouse>? warehouse;
  late WarehouseListStatus warehouseListStatus;

  WarehouseListState({
    this.warehouse,
    this.warehouseListStatus = WarehouseListStatus.loading,
  });

  @override
  List<Object?> get props => [warehouse, warehouseListStatus];

  WarehouseListState copyWith({
    List<Warehouse>? warehouse,
    WarehouseListStatus? warehouseListStatus,
  }) {
    return WarehouseListState(
      warehouse: warehouse ?? this.warehouse,
      warehouseListStatus: warehouseListStatus ?? this.warehouseListStatus,
    );
  }
}

enum WarehouseListStatus {
  loading,
  ready,
  failed,
}
