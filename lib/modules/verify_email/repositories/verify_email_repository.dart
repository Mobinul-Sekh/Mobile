// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/verify_email/models/verify_email_request.dart';
import 'package:bitecope/modules/verify_email/models/verify_email_response.dart';
import 'package:bitecope/modules/verify_email/providers/verify_email_provider.dart';

class VerifyEmailRepository extends CommonRepository {
  final VerifyEmailProvider _verifyEmailProvider = VerifyEmailProvider();

  Future<VerifyEmailResponse?> verifyEmail({
    required String otp,
  }) async {
    final VerifyEmailRequest request = VerifyEmailRequest(
      otp: otp,
    );
    final Map<String, dynamic>? responseMap =
        await _verifyEmailProvider.verifyEmail(request);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final VerifyEmailResponse response =
        VerifyEmailResponse.fromMap(responseMap);
    return response;
  }
}
