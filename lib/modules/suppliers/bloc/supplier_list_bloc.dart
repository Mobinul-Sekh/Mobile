// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:bitecope/modules/suppliers/models/get_suppliers_response.dart';
import 'package:bitecope/modules/suppliers/models/supplier.dart';
import 'package:bitecope/modules/suppliers/repositories/supplier_repository.dart';

part 'supplier_list_state.dart';

class SupplierListBloc extends Cubit<SupplierListState> {
  final SupplierRepository _supplierRepository;

  SupplierRepository get repository => _supplierRepository;

  SupplierListBloc(this._supplierRepository) : super(SupplierListState()) {
    _init();
  }

  Future<void> _init() async {
    final GetSuppliersResponse? _response =
        await _supplierRepository.getSuppliers();
    if (_response == null || !_response.status) {
      emit(state.copyWith(
        supplierListStatus: SupplierListStatus.failed,
      ));
      return;
    }
    emit(state.copyWith(
      suppliers: _response.suppliers,
      supplierListStatus: SupplierListStatus.ready,
    ));
  }
}
