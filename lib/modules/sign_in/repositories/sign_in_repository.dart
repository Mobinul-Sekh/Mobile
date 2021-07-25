// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:bitecope/modules/sign_in/models/signin_reponse_model.dart';
import 'package:bitecope/modules/sign_in/models/signin_request_model.dart';
import 'package:bitecope/modules/sign_in/providers/sign_in_provider.dart';

class SignInRepository {
  final SignInProvider signInProvider = SignInProvider();

  Future<SignInResponseModel?> signInWithUserNameAndPassword({
    required String username,
    required String password,
  }) async {
    final SignInRequestModel signInRequestModel = SignInRequestModel(
      username: username,
      password: password,
    );
    final Map<String, dynamic>? responseMap =
        await signInProvider.getSignInToken(signInRequestModel);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final SignInResponseModel response =
        SignInResponseModel.fromMap(responseMap);
    return response;
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }
}
