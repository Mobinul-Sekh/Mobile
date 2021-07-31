// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/worker_initialize/models/worker_initialize_request.dart';

class WorkerInitializeProvider extends CommonProvider {
  Future<Map<String, dynamic>?> insertWorker(
      WorkerInitializeRequest request, String token) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.workerInitialize,
        data: request.toMap(),
        options: Options(headers: {
          "Authorization": "Token $token",
        }),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }
}
