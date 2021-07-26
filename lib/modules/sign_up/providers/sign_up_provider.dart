// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_request.dart';

class SignUpProvider extends CommonProvider {
  Future<Map<String, dynamic>?> register(SignUpRequest request) async {
    final Response response = await CommonProvider.dio.post(
      AppURLs.register,
      data: request.toMap(),
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  }
}
