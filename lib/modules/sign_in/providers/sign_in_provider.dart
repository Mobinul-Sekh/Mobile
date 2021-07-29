// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/sign_in/models/signin_request_model.dart';

class SignInProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getSignInToken(
      SignInRequestModel signInRequestModel) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.login,
        data: signInRequestModel.toDatabaseJson(),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }
}
