part of 'warehouse_bloc.dart';

class WarehouseState with EquatableMixin {
  late final String? id;
  late final BlocFormField<String> name;
  late final BlocFormField<String> description;
  LocaleString? error;
  late WarehouseStatus warehouseStatus;

  WarehouseState({
    this.id,
    BlocFormField<String>? name,
    BlocFormField<String>? description,
    this.error,
    this.warehouseStatus = WarehouseStatus.ready,
  }) {
    this.name = name ?? BlocFormField<String>();

    this.description = description ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        error,
        warehouseStatus,
      ];

  WarehouseState copyWith({
    String? id,
    BlocFormField<String>? name,
    BlocFormField<String>? description,
    LocaleString? error,
    WarehouseStatus? warehouseStatus,
  }) {
    return WarehouseState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      error: error ?? this.error,
      warehouseStatus: warehouseStatus ?? this.warehouseStatus,
    );
  }
}

enum WarehouseStatus {
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
