import 'package:bitecope/config/constants.dart';
import 'package:bitecope/data/models/sign_up_request.dart';
import 'package:dio/dio.dart';

class AccountProvider {
  static Dio dio = Dio();

  Future<Map<String, dynamic>?> register(SignUpRequest request) async {
    final Response response = await dio.post(
      AppConstants.registerURL,
      data: {
        'username': request.username,
        'phone_no': request.phoneNumber,
        'email': request.email,
        'password': request.password,
        'confirm_password': request.confirmPassword,
        'recovery_question': request.recoveryQuestion,
        'recovery_answer': request.recoveryAnswer,
        'user_type': request.userType,
      },
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  }
}
