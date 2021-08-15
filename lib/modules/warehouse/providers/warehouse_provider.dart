// Package imports:

import 'package:bitecope/modules/warehouse/models/add_warehouse_request.dart';
import 'package:bitecope/modules/warehouse/models/delete_warehouse_request.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/buyers/models/add_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_request.dart';

class WarehouseProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getWarehouses(String token) async {
    try {
      final Response response = await CommonProvider.dio.get(
        AppURLs.getWarehouses,
        options: Options(
          headers: {
            "Authorization": "Token $token",
          },
        ),
      );

      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }

  Future<Map<String, dynamic>?> addWarehouse(
    AddWarehouseRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.addWarehouse,
        data: request.toMap(),
        options: Options(
          headers: {
            "Authorization": "Token $token",
          },
        ),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }

  Future<Map<String, dynamic>?> deleteWarehouse(
    DeleteWarehouseRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.deleteWarehouse,
        data: request.toMap(),
        options: Options(
          headers: {
            "Authorization": "Token $token",
          },
        ),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }
}
