// Package imports:

import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/buyers/models/add_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/delete_buyer_request.dart';
import 'package:bitecope/modules/buyers/models/edit_buyer_request.dart';

class BuyerProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getBuyers(String token) async {
    try {
      final Response response = await CommonProvider.dio.get(
        AppURLs.getBuyers,
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

  Future<Map<String, dynamic>?> addBuyer(
    AddBuyerRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.addBuyer,
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

  Future<Map<String, dynamic>?> editBuyer(
    EditBuyerRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.put(
        AppURLs.editBuyer,
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

  Future<Map<String, dynamic>?> deleteBuyer(
    DeleteBuyerRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.deleteBuyer,
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
