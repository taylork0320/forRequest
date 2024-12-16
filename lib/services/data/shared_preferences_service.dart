import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static SharedPreferences get() {
    return _instance;
  }
}