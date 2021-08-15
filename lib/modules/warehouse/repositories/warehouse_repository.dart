// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/buyers/models/add_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/add_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_response.dart';
import 'package:bitecope/modules/buyers/models/get_buyer_response.dart';
import 'package:bitecope/modules/buyers/providers/buyer_provider.dart';
import 'package:bitecope/modules/warehouse/models/add_warehouse_request.dart';
import 'package:bitecope/modules/warehouse/models/add_warehouse_response.dart';
import 'package:bitecope/modules/warehouse/models/delete_warehouse_request.dart';
import 'package:bitecope/modules/warehouse/models/delete_warehouse_response.dart';
import 'package:bitecope/modules/warehouse/models/get_warehouse_response.dart';
import 'package:bitecope/modules/warehouse/providers/warehouse_provider.dart';

class WarehouseRepository extends CommonRepository {
  final WarehouseProvider _warehouseProvider = WarehouseProvider();

  Future<GetWarehousesResponse?> getWarehouses() async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final Map<String, dynamic>? _responseMap =
        await _warehouseProvider.getWarehouses(_authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final GetWarehousesResponse _response =
        GetWarehousesResponse.fromMap(_responseMap);
    return _response;
  }

  Future<AddWarehouseResponse?> addWarehouse({
    required String name,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final AddWarehouseRequest request = AddWarehouseRequest(
      name: name,
      description: description,
    );

    final Map<String, dynamic>? _responseMap =
        await _warehouseProvider.addWarehouse(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final AddWarehouseResponse _response =
        AddWarehouseResponse.fromMap(_responseMap);
    return _response;
  }

  Future<DeleteWarehouseResponse?> deleteWarehouse({
    required String warehouseID,
    String? description,
  }) async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final DeleteWarehouseRequest request = DeleteWarehouseRequest(
      warehouseID: warehouseID,
    );
    final Map<String, dynamic>? _responseMap =
        await _warehouseProvider.deleteWarehouse(request, _authToken);

    // If request failed
    if (_responseMap == null) return null;

    // If request okay
    final DeleteWarehouseResponse _response =
        DeleteWarehouseResponse.fromMap(_responseMap);
    return _response;
  }
}
