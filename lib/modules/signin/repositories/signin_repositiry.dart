import 'package:bitecope/modules/signin/models/signin_reponse_model.dart';
import 'package:bitecope/modules/signin/models/signin_request_model.dart';
import 'package:bitecope/data/signin_api_call.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInRepository {
  Future<SignInResponseModel?> signInWithUserNameAndPassword({
    required String username,
    required String password,
  }) async {
    final SignInRequestModel signInRequestModel =
        SignInRequestModel(username: username, password: password);
    final Map<String, dynamic>? signInResponseModel =
        await getSignInToken(signInRequestModel);
// If request failed
    if (signInResponseModel == null) return null;

    // If request okay
    final SignInResponseModel response =
        SignInResponseModel.fromMap(signInResponseModel);
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
