part of 'supplier_list_bloc.dart';

class SupplierListState with EquatableMixin {
  List<Supplier>? suppliers;
  SupplierListStatus supplierListStatus;

  SupplierListState({
    this.suppliers,
    this.supplierListStatus = SupplierListStatus.loading,
  });

  @override
  List<Object?> get props => [suppliers, supplierListStatus];

  SupplierListState copyWith({
    List<Supplier>? suppliers,
    SupplierListStatus? supplierListStatus,
  }) {
    return SupplierListState(
      suppliers: suppliers ?? this.suppliers,
      supplierListStatus: supplierListStatus ?? this.supplierListStatus,
    );
  }
}

enum SupplierListStatus {
  loading,
  ready,
  failed,
}
