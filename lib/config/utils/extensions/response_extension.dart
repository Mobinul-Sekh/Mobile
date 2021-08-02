// Package imports:
import 'package:dio/dio.dart';

extension ResponseExtension on Response? {
  Map<String, dynamic>? asMap() {
    if (this == null) {
      return null;
    }
    final Map<String, dynamic> _responseMap;
    if (this!.data is List) {
      _responseMap = {
        'list': this!.data,
      };
    } else {
      _responseMap = this!.data as Map<String, dynamic>;
    }
    _responseMap['statusCode'] = this!.statusCode;
    return _responseMap;
  }
}
