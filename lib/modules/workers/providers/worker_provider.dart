// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';
import 'package:bitecope/modules/workers/models/delete_worker_request.dart';

class WorkerProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getWorkers(String token) async {
    try {
      final Response response = await CommonProvider.dio.get(
        AppURLs.getWorkers,
        options: Options(
          headers: {
            "Authorization": "Token $token",
          },
        ),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }

  Future<Map<String, dynamic>?> deleteWorker(
    DeleteWorkerRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.put(
        AppURLs.deleteWorker,
        data: request.toMap(),
        options: Options(
          headers: {
            "Authorization": "Token $token",
          },
        ),
      );
      return response.asMap();
    } catch (e) {
      return errorResponse(e);
    }
  }
}
