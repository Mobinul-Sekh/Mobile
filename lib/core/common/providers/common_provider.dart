// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/core/common/models/account_status_request.dart';

class CommonProvider {
  static final Dio dio = Dio();

  Future<Map<String, dynamic>?> accountStatus(
      AccountStatusRequest request) async {
    final Response response = await dio.post(
      AppURLs.accountStatus,
      data: request.toMap(),
    );
    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    return null;
  }
}
