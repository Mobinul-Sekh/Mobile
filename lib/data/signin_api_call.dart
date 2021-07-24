import 'package:bitecope/constants/api_path.dart';
import 'package:bitecope/modules/signin/models/signin_reponse_model.dart';
import 'package:bitecope/modules/signin/models/signin_request_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Dio _dio = Dio();
Future<Map<String, dynamic>?> getSignInToken(
    SignInRequestModel signInRequestModel) async {
  final Response response = await _dio.post(
    loginUrl,
    data: signInRequestModel.toDatabaseJson(),
  );
  if (response.statusCode == 200) {
    print(response.data);
    return response.data as Map<String, dynamic>;
  } else {
    throw Exception(response.data);
  }
}
