import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> login(String emailOrPhone, String password);
  Future<bool> logout();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<bool> login(String emailOrPhone, String password) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('user_email', emailOrPhone);

      return true;
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  @override
  Future<bool> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);
      await prefs.remove('user_email');

      return true;
    } catch (e) {
      throw Exception('Logout failed on data sources: ${e.toString()}');
    }
  }
}
