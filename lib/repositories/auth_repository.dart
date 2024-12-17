import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:sasimee/models/request/auth/post_email_send_request.dart';
import 'package:sasimee/models/request/auth/post_email_verify_request.dart';
import 'package:sasimee/models/request/auth/post_login_request.dart';
import 'package:sasimee/models/request/auth/post_register_request.dart';
import 'package:sasimee/models/response/auth/post_email_send_response.dart';
import 'package:sasimee/models/response/auth/post_login_response.dart';
import 'package:sasimee/models/response/default_response.dart';
import 'package:sasimee/models/response/mypage/profile_response.dart';

import '../services/api/auth_api.dart';
import '../services/data/secure_storage_service.dart';
import '../services/network/dio_service.dart';
import '../utils/constants.dart';
import '../utils/logger.dart';

class AuthRepository {
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
  Future<PostLoginResponse?> login(String email, String password) async {
    try {
      var loginResponse = await _authApi
          .postLogin(PostLoginRequest(email: email, password: password));
      return loginResponse;
    } catch (e) {
      logger.e("Login Error", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }

  /// 인증 메일 보내기
  Future<PostEmailSendResponse?> sendAuthEmail(String email) async {
    try {
      final request = PostEmailSendRequest(
        to: email,
        subject: '인증 메일',
        message: '사심이',
      );

      var response = await _authApi.send(request);
      return response;
    } catch (e) {
      logger.e("Failed to send authentication email.", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }

  /// 인증 메일 보내기
  Future<DefaultResponse?> verifyEmail(String email, String authNum) async {
    try {
      final request = PostEmailVerifyRequest(
        email: email,
        authNum: authNum,
      );

      var response = await _authApi.verify(request);
      return response;
    } catch (e) {
      logger.e("Failed to verify email authentication.", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }

  /// 회원가입
  Future<DefaultResponse?> register(PostRegisterRequest request) async {
    try {
      var response = await _authApi.register(request);
      return response;
    } catch (e) {
      logger.e("Failed to register.", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }

  /// 프로필 가져오기
  Future<FrProfile?> getProfile() async {
    try {
      var response = await _authApi.getProfile();
      return response;
    } catch (e) {
      logger.e("Failed to register.", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }
}
