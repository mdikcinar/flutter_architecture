import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/enums/preferances_keys_enum.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._init();
  SharedPreferences? _sharedPreferences;
  static CacheManager get instance => _instance;

  CacheManager._init() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
    });
  }

  static Future sharedPreferencesInit() async {
    instance._sharedPreferences ??= await SharedPreferences.getInstance();
  }

  Future<void> clearAll() async {
    await _sharedPreferences!.clear();
  }

  Future<void> removeKey(PreferancesKeys key) async {
    await _sharedPreferences!.remove(key.toString());
  }

  Future<void> setStringValue(PreferancesKeys key, String value) async {
    await _sharedPreferences!.setString(key.toString(), value);
  }

  Future<void> setStringList(PreferancesKeys key, List<String> value) async {
    await _sharedPreferences!.setStringList(key.toString(), value);
  }

  Future<void> setBoolValue(PreferancesKeys key, bool value) async {
    await _sharedPreferences!.setBool(key.toString(), value);
  }

  bool containsKey(PreferancesKeys key) => _sharedPreferences!.containsKey(key.toString());

  String getStringValue(PreferancesKeys key) => _sharedPreferences!.getString(key.toString()) ?? '';
  List<String>? getStringList(PreferancesKeys key) => _sharedPreferences!.getStringList(key.toString());
  bool getBoolValue(PreferancesKeys key) => _sharedPreferences!.getBool(key.toString()) ?? false;
}
