// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/sign_in/models/signin_request_model.dart';

// Project imports:

class SignInProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getSignInToken(
      SignInRequestModel signInRequestModel) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.login,
        data: signInRequestModel.toDatabaseJson(),
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      if (e is DioError && e.response!.statusCode! < 500) {
        return e.response?.data as Map<String, dynamic>;
      }
      return null;
    }
  }
}
