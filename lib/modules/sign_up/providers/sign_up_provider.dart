// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_request.dart';

class SignUpProvider extends CommonProvider {
  Future<Map<String, dynamic>?> register(SignUpRequest request) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.register,
        data: request.toMap(),
      );
      return response.asMap();
    } catch (e) {
      if (e is DioError && e.response!.statusCode! < 500) {
        return e.response.asMap();
      }
      return null;
    }
  }
}
