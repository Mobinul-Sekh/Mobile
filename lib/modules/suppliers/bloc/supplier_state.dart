part of 'supplier_bloc.dart';

class SupplierState with EquatableMixin {
  List<Supplier>? suppliers;
  SupplierStatus supplierStatus;

  SupplierState({
    this.suppliers,
    this.supplierStatus = SupplierStatus.loading,
  });

  @override
  List<Object?> get props => [suppliers, supplierStatus];

  SupplierState copyWith({
    List<Supplier>? suppliers,
    SupplierStatus? supplierStatus,
  }) {
    return SupplierState(
      suppliers: suppliers ?? this.suppliers,
      supplierStatus: supplierStatus ?? this.supplierStatus,
    );
  }
}

enum SupplierStatus {
  loading,
  ready,
  failed,
}
