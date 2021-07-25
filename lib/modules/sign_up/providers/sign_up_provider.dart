// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/modules/sign_up/models/sign_up_request.dart';

class SignUpProvider {
  static final Dio _dio = Dio();

  Future<Map<String, dynamic>?> register(SignUpRequest request) async {
    final Response response = await _dio.post(
      AppURLs.register,
      data: request.toMap(),
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  }
}
