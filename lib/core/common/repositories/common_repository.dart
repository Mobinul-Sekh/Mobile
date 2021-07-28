// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:bitecope/core/common/models/account_status_request.dart';
import 'package:bitecope/core/common/models/account_status_response.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';

class CommonRepository {
  final CommonProvider _commonProvider = CommonProvider();

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('token', token);
  }

  Future<AccountStatusResponse?> accountStatus({
    required String username,
  }) async {
    final AccountStatusRequest request =
        AccountStatusRequest(username: username);
    final Map<String, dynamic>? responseMap =
        await _commonProvider.accountStatus(request);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final AccountStatusResponse response =
        AccountStatusResponse.fromMap(responseMap);
    return response;
  }
}
