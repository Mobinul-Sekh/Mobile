// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/models/account_status_request.dart';
import 'package:bitecope/core/common/models/device_details_request.dart';
import 'package:bitecope/core/common/models/logout_request.dart';

class CommonProvider {
  static final Dio dio = Dio();

  Future<Map<String, dynamic>?> accountStatus(
      AccountStatusRequest request) async {
    try {
      final Response response = await dio.get(
        AppURLs.accountStatus,
        data: request.toMap(),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }

  Future<Map<String, dynamic>?> logout(
    LogoutRequest request,
    String token,
  ) async {
    try {
      final Response response = await dio.post(
        AppURLs.logout,
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

  Future<Map<String, dynamic>?> deviceDetails(
    DeviceDetailsRequest request,
    String token,
  ) async {
    try {
      final Response response = await dio.post(
        AppURLs.deviceDetails,
        data: {
          'detail': request.toJson(),
        },
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

  Map<String, dynamic>? errorResponse(Object e) {
    if (e is DioError) {
      if (e.response != null && e.response!.statusCode != null) {
        return e.response.asMap();
      }
    }
    return null;
  }
}
