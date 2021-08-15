// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/owner_subscription/models/owner_subscription_request.dart';

class OwnerSubscriptionProvider extends CommonProvider {
  Future<Map<String, dynamic>?> activate(
      OwnerSubscriptionRequest request) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.redeemCode,
        data: request.toMap(),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }
}
