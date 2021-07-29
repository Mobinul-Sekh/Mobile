import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/modules/post_signin_owner/model/post_owner_request_model.dart';
import 'package:dio/dio.dart';

class PostOwnerProvider {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> insertOwnerDetailsApi(
      {required PostOwnerRequestModel request, required String? token}) async {
    //_dio.options.headers['content-Type'] = 'application/json';
    _dio.options.headers["authorization"] = "Token $token";
    final Response response = await _dio.post(
      AppURLs.ownerInsertDetails,
      data: request.toDatabaseJson(),
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }

    return null;
  }
}
