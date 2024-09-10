import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_token_repo.g.dart';

@riverpod
AuthTokenRepo authTokenRepo(AuthTokenRepoRef ref) {
  return AuthTokenRepo();
}

class AuthTokenRepo {
  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<String?> getToken() async {
    return await _prefs.getString('x-auth-token');
  }

  Future<void> setToken(String token) async {
    return await _prefs.setString('x-auth-token', token);
  }

  Future<void> invalidateToken() async {
    return await _prefs.remove('x-auth-token');
  }
}
