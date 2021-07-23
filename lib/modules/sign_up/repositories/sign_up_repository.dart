// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:bitecope/core/authentication/models/user.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_request.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_response.dart';
import 'package:bitecope/modules/sign_up/providers/sign_up_provider.dart';

class SignUpRepository {
  final SignUpProvider _accountProvider = SignUpProvider();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

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
      userType: userTypeID[userType].toString(),
    );
    final Map<String, dynamic>? responseMap =
        await _accountProvider.register(request);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final SignUpResponse response = SignUpResponse.fromMap(responseMap);
    return response;
  }
}
