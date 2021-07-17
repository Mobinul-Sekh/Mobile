import 'package:shared_preferences/shared_preferences.dart';

class AccountRepository {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
}
