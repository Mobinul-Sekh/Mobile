// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/suppliers/models/add_supplier_request.dart';
import 'package:bitecope/modules/suppliers/models/add_supplier_response.dart';
import 'package:bitecope/modules/suppliers/models/delete_supplier_request.dart';
import 'package:bitecope/modules/suppliers/models/delete_supplier_response.dart';
import 'package:bitecope/modules/suppliers/models/edit_supplier_request.dart';
import 'package:bitecope/modules/suppliers/models/edit_supplier_response.dart';
import 'package:bitecope/modules/suppliers/models/get_suppliers_response.dart';
import 'package:bitecope/modules/suppliers/providers/supplier_provider.dart';

class SupplierRepository extends CommonRepository {
  final SupplierProvider _supplierProvider = SupplierProvider();

  Future<GetSuppliersResponse?> getSuppliers() async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final Map<String, dynamic>? _responseMap =
        await _supplierProvider.getSuppliers(_authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final GetSuppliersResponse _response =
        GetSuppliersResponse.fromMap(_responseMap);
    return _response;
  }

  Future<AddSupplierResponse?> addSupplier({
    required String name,
    required String phoneNumber,
    required String address,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final AddSupplierRequest request = AddSupplierRequest(
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      description: description,
    );
    final Map<String, dynamic>? _responseMap =
        await _supplierProvider.addSupplier(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final AddSupplierResponse _response =
        AddSupplierResponse.fromMap(_responseMap);
    return _response;
  }

  Future<EditSupplierResponse?> editSupplier({
    required String supplierID,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final EditSupplierRequest request = EditSupplierRequest(
      supplierID: supplierID,
      description: description,
    );
    final Map<String, dynamic>? _responseMap =
        await _supplierProvider.editSupplier(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final EditSupplierResponse _response =
        EditSupplierResponse.fromMap(_responseMap);
    return _response;
  }

  Future<DeleteSupplierResponse?> deleteSupplier({
    required String supplierID,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final DeleteSupplierRequest request = DeleteSupplierRequest(
      supplierID: supplierID,
    );
    final Map<String, dynamic>? _responseMap =
        await _supplierProvider.deleteSupplier(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final DeleteSupplierResponse _response =
        DeleteSupplierResponse.fromMap(_responseMap);
    return _response;
  }
}
