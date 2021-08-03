// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/suppliers/models/add_supplier_request.dart';

class SupplierProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getSuppliers(String token) async {
    try {
      final Response response = await CommonProvider.dio.get(
        AppURLs.getSuppliers,
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

  Future<Map<String, dynamic>?> addSupplier(
    AddSupplierRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.addSupplier,
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
