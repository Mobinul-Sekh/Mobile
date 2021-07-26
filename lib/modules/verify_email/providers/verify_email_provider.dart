// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/verify_email/models/verify_email_request.dart';

class VerifyEmailProvider extends CommonProvider {
  Future<Map<String, dynamic>?> verifyEmail(VerifyEmailRequest request) async {
    final Response response = await CommonProvider.dio.post(
      "${AppURLs.verifyEmail}/${request.otp}",
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  }
}
