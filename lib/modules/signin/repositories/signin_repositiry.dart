import 'package:bitecope/modules/signin/models/signin_reponse_model.dart';
import 'package:bitecope/modules/signin/models/signin_request_model.dart';
import 'package:bitecope/data/signin_api_call.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInRepository {
  Future<SignInResponseModel> SignInWithUserNameAndPassword({
    required String username,
    required String password,
  }) async {
    SignInRequestModel signInRequestModel =
        SignInRequestModel(username: username, password: password);
    SignInResponseModel signInResponseModel =
        await getSignInToken(signInRequestModel);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', signInResponseModel.token);
    return signInResponseModel;
  }
}
