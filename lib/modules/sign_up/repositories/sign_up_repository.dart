// Project imports:
import 'package:bitecope/core/common/models/user.dart';
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_request.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_response.dart';
import 'package:bitecope/modules/sign_up/providers/sign_up_provider.dart';

class SignUpRepository extends CommonRepository {
  final SignUpProvider _signUpProvider = SignUpProvider();

  Future<SignUpResponse?> registerUser({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
    required String confirmPassword,
    required String recoveryQuestion,
    required String recoveryAnswer,
    required UserType userType,
  }) async {
    final SignUpRequest request = SignUpRequest(
      email: email,
      username: username,
      phoneNumber: phoneNumber,
      password: password,
      confirmPassword: confirmPassword,
      recoveryQuestion: recoveryQuestion,
      recoveryAnswer: recoveryAnswer,
      userType: userType.id.toString(),
    );
    final Map<String, dynamic>? responseMap =
        await _signUpProvider.register(request);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final SignUpResponse response = SignUpResponse.fromMap(responseMap);
    return response;
  }
}
