// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
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
}
