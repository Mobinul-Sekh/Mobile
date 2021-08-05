part of 'supplier_bloc.dart';

class SupplierState with EquatableMixin {
  late final BlocFormField<String> name;
  late final BlocFormField<String> phoneNumber;
  late final BlocFormField<String> address;
  late final BlocFormField<String> description;
  LocaleString? error;
  SupplierStatus supplierStatus;

  SupplierState({
    BlocFormField<String>? name,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? address,
    BlocFormField<String>? description,
    this.error,
    this.supplierStatus = SupplierStatus.ready,
  }) {
    this.name = name ?? BlocFormField<String>();
    this.phoneNumber = phoneNumber ?? BlocFormField<String>();
    this.address = address ?? BlocFormField<String>();
    this.description = description ?? BlocFormField<String>();
  }

  @override
  List<Object?> get props => [
        name,
        phoneNumber,
        address,
        description,
        error,
        supplierStatus,
      ];

  SupplierState copyWith({
    BlocFormField<String>? name,
    BlocFormField<String>? phoneNumber,
    BlocFormField<String>? address,
    BlocFormField<String>? description,
    LocaleString? error,
    SupplierStatus? supplierStatus,
  }) {
    return SupplierState(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      description: description ?? this.description,
      error: error ?? this.error,
      supplierStatus: supplierStatus ?? this.supplierStatus,
    );
  }
}

enum SupplierStatus {
  ready,
  validated,
  confirm,
  loading,
  done,
}
