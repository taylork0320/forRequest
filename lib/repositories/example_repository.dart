import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/data/shared_preferences_service.dart';
import '../services/api/auth_api.dart';
import '../services/data/secure_storage_service.dart';
import '../services/network/dio_service.dart';

class SettingRepository {
  final AuthApi _authApi = AuthApi(DioService().get());
  final SharedPreferences _sharedPreferences = SharedPreferencesService.get();
  final FlutterSecureStorage _secureStorage = SecureStorageService().get();

  // Future<bool> withDraw() async {
  //   var withdrawResponse = await _authApi.postQuitUser();
  //   return withdrawResponse.success;
  // }
  //
  // Future<void> clearAllData() async {
  //   await _secureStorage.deleteAll();
  //   await _sharedPreferences.clear();
  // }
  //
  // Future<bool> logout() async {
  //   var logoutResponse = await _authApi.putLogout();
  //   return logoutResponse.success;
  // }
}
