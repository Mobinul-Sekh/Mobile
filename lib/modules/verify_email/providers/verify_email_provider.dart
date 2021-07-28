// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/verify_email/models/resend_otp_request.dart';
import 'package:bitecope/modules/verify_email/models/verify_email_request.dart';

class VerifyEmailProvider extends CommonProvider {
  Future<Map<String, dynamic>?> verifyEmail(VerifyEmailRequest request) async {
    try {
      final Response response = await CommonProvider.dio.post(
        "${AppURLs.verifyEmail}${request.otp}/",
      );
      return response.asMap();
    } catch (e) {
      if (e is DioError && e.response!.statusCode! < 500) {
        return e.response.asMap();
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> resendOTP(ResendOTPRequest request) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.resendOTP,
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
