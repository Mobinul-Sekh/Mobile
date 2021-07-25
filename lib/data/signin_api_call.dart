import 'package:bitecope/constants/api_path.dart';
import 'package:bitecope/modules/signin/models/signin_request_model.dart';
import 'package:dio/dio.dart';

// BaseOptions options = BaseOptions(
//   baseUrl: loginUrl,
//   connectTimeout: 5000,
//   receiveTimeout: 3000,
//   headers: {
//     HttpHeaders.acceptHeader: "accept: application/json",
//   },
// );
// Dio _dio = Dio(options);
Dio _dio = Dio();
Future<Map<String, dynamic>?> getSignInToken(
    SignInRequestModel signInRequestModel) async {
  try {
    final Response response =
        await _dio.post(loginUrl, data: signInRequestModel.toDatabaseJson()
            // data: {
            //   'username': signInRequestModel.username,
            //   'password': signInRequestModel.password,
            // },
            );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  } catch (e) {
    if (e is DioError && e.response!.statusCode! < 500) {
      return e.response?.data as Map<String, dynamic>;
    }
    return null;
  }
}
