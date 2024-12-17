import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:sasimee/models/request/auth/post_login_request.dart';
import 'package:sasimee/models/response/auth/post_login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/data/shared_preferences_service.dart';
import '../services/api/auth_api.dart';
import '../services/data/secure_storage_service.dart';
import '../services/network/dio_service.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

class LoginRepository {
  final AuthApi _authApi = AuthApi(DioService().get());
  final Logger logger = LoggerUtils().get();
  // final SharedPreferences _sharedPreferences = SharedPreferencesService.get();
  final FlutterSecureStorage _secureStorage = SecureStorageService().get();

  /// 서비스 자체 Access Token 저장
  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(
        key: ACCESS_TOKEN_STORAGE_KEY, value: accessToken);
  }

  /// 서비스 자체 Refresh Token 저장
  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(
        key: REFRESH_TOKEN_STORAGE_KEY, value: refreshToken);
  }

  /// 로그인
  Future<PostLoginResponse?> login(
      String email, String password) async {
    try {
      var loginResponse = await _authApi.postLogin(PostLoginRequest(
          email: email, password: password));
      return loginResponse;
    } catch (e) {
      logger.e("Login Error", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }
}
