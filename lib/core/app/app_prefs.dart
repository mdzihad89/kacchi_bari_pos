
import 'package:shared_preferences/shared_preferences.dart';



class AppPreferences {
  final SharedPreferencesWithCache _sharedPreferencesWithCache;

  static const keyLastUpdatedDate = 'lastUpdatedDate';
  static const keyCurrentSerialNumber = 'currentSerialNumber';
  static const String tokenKey = "token";
  AppPreferences(this._sharedPreferencesWithCache);

  Future<void> saveCredential(String token) async {
    await _sharedPreferencesWithCache.setString(tokenKey, token);
  }

  String? getCredential() {
    return _sharedPreferencesWithCache.getString(tokenKey) ;
  }

  Future<void> removeCredential() async {
    _sharedPreferencesWithCache.remove(tokenKey);
  }

  Future<String> getSerialNumber() async {
    final now = DateTime.now();
    final today = '${now.year}-${now.month}-${now.day}';
    final lastUpdatedDate = _sharedPreferencesWithCache.getString(keyLastUpdatedDate);
    if (lastUpdatedDate == today) {
      int currentSerial = _sharedPreferencesWithCache.getInt(keyCurrentSerialNumber) ?? 0;
      currentSerial++;
      await _sharedPreferencesWithCache.setInt(keyCurrentSerialNumber, currentSerial);
      return currentSerial.toString();
    } else {
      await _sharedPreferencesWithCache.setString(keyLastUpdatedDate, today);
      await _sharedPreferencesWithCache.setInt(keyCurrentSerialNumber, 1);
      return "1";
    }
  }
}
