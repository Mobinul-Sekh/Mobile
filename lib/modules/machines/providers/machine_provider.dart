// Package imports:

import 'package:bitecope/modules/machines/models/add_machine_request.dart';
import 'package:bitecope/modules/machines/models/delete_machine_request.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:bitecope/config/constants/app_urls.dart';
import 'package:bitecope/config/utils/extensions/response_extension.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';

class MachineProvider extends CommonProvider {
  Future<Map<String, dynamic>?> getMachines(String token) async {
    try {
      final Response response = await CommonProvider.dio.get(
        AppURLs.getMachines,
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

  Future<Map<String, dynamic>?> addMachine(
    AddMachineRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.addMachine,
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

  Future<Map<String, dynamic>?> deleteMachine(
    DeleteMachineRequest request,
    String token,
  ) async {
    try {
      final Response response = await CommonProvider.dio.post(
        AppURLs.deleteMachine,
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
