// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'package:bitecope/core/common/models/account_status_request.dart';
import 'package:bitecope/core/common/models/account_status_response.dart';
import 'package:bitecope/core/common/models/logout_request.dart';
import 'package:bitecope/core/common/models/logout_response.dart';
import 'package:bitecope/core/common/providers/common_provider.dart';

class CommonRepository {
  final CommonProvider _commonProvider = CommonProvider();

  Future<String?> getToken() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    return _preferences.getString('token');
  }

  Future<void> setToken(String token) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    _preferences.setString('token', token);
  }

  Future<void> removeToken() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    _preferences.remove('token');
  }

  Future<String?> getUsername() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    return _preferences.getString('username');
  }

  Future<void> setUsername(String username) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    _preferences.setString('username', username);
  }

  Future<void> removeUsername() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    _preferences.remove('username');
  }

  Future<String?> getExpiry() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    return _preferences.getString('expiry');
  }

  Future<void> setExpiry(String expiry) async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    _preferences.setString('expiry', expiry);
  }

  Future<void> removeExpiry() async {
    final SharedPreferences _preferences =
        await SharedPreferences.getInstance();
    _preferences.remove('expiry');
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

  Future<LogoutResponse?> logout() async {
    final String? _authToken = await getToken();
    if (_authToken == null) return null;
    final LogoutRequest request = LogoutRequest(token: _authToken);
    final Map<String, dynamic>? responseMap =
        await _commonProvider.logout(request, _authToken);

    // If request failed
    if (responseMap == null) return null;

    // If request okay
    final LogoutResponse response = LogoutResponse.fromMap(responseMap);
    if (response.status) {
      removeUsername();
      removeToken();
      removeExpiry();
    }
    return response;
  }
}
