// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/suppliers/models/get_suppliers_response.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/modules/suppliers/repositories/supplier_repository.dart';

part 'supplier_state.dart';

class SupplierBloc extends Cubit<SupplierState> {
  final SupplierRepository _supplierRepository;

  SupplierBloc(this._supplierRepository) : super(SupplierState()) {
    _init();
  }

  Future<void> _init() async {
    final GetSuppliersResponse? _response =
        await _supplierRepository.getSuppliers();
    if (_response == null || !_response.status) {
      emit(state.copyWith(
        supplierStatus: SupplierStatus.failed,
      ));
      return;
    }
    emit(state.copyWith(
      suppliers: _response.suppliers,
      supplierStatus: SupplierStatus.ready,
    ));
  }
}
