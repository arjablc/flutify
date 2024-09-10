import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Ideally would create an abstract class with some methods to interact with the local storage
// but too much work and I am not doing TDD

part 'shared_prefs.g.dart';

@riverpod
LocalPrefService localPrefService(LocalPrefServiceRef ref) {
  return LocalPrefService();
}

class LocalPrefService {
// SharedPreferencesAsync is a new API and recommended officially

  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  Future<String?> getString(String key) async {
    return await _asyncPrefs.getString(key);
  }

  Future<void> putString({required String key, required String value}) async {
    return await _asyncPrefs.setString(key, value);
  }

  Future<bool> has(String key) async {
    return await _asyncPrefs.containsKey(key);
  }

  Future<void> remove(String key) async {
    return await _asyncPrefs.remove(key);
  }
}
