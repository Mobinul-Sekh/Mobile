// Package imports:

// Project imports:
import 'package:bitecope/core/common/repositories/common_repository.dart';
import 'package:bitecope/modules/sign_in/models/signin_reponse_model.dart';
import 'package:bitecope/modules/sign_in/models/signin_request_model.dart';
import 'package:bitecope/modules/sign_in/providers/sign_in_provider.dart';

class SignInRepository extends CommonRepository {
  final SignInProvider _signInProvider = SignInProvider();

  Future<SignInResponseModel?> signInWithUserNameAndPassword({
    required String username,
    required String password,
  }) async {
    final SignInRequestModel signInRequestModel = SignInRequestModel(
      username: username,
      password: password,
    );
    final Map<String, dynamic>? responseMap =
        await _signInProvider.getSignInToken(signInRequestModel);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final SignInResponseModel response =
        SignInResponseModel.fromMap(responseMap);
    return response;
  }
}
