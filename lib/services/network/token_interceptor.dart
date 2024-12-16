import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../../utils/constants.dart';
import '../../utils/logger.dart';
import '../api/auth_api.dart';
import '../data/secure_storage_service.dart';

class TokenInterceptor extends Interceptor {
  final Logger logger = LoggerUtils().get();
  final FlutterSecureStorage secureStorage = SecureStorageService().get();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d("[Network / [${options.method}] ${options.uri}] Start Request");

    if (await secureStorage.containsKey(key: ACCESS_TOKEN_STORAGE_KEY)) {
      // 저장된 Access Token 꺼내기
      final accessToken =
          await secureStorage.read(key: ACCESS_TOKEN_STORAGE_KEY);

      // Access Token이 null이 아니라면
      if (accessToken != null) {
        // Header에 Access Token 추가
        options.headers.addAll({'Authorization': 'Bearer $accessToken'});
      }
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Access Token 만료되었을 경우
    if (err.response?.statusCode == 401) {
      logger.w(
          "[Network / [${err.requestOptions.method}] ${err.requestOptions.uri}] Unauthorized");
      // 저장된 Refresh Token 조회
      final refreshToken =
          await secureStorage.read(key: REFRESH_TOKEN_STORAGE_KEY);

      // Refresh Token이 Storage에 없을 경우 Reject
      if (refreshToken == null) return handler.reject(err);

      // Access Token 새로 발급받기 위한 임시 Dio 객체
      var dioBaseOption =
          BaseOptions(baseUrl: const String.fromEnvironment("API_URL"));
      final dio = Dio(dioBaseOption);

      // Header에 RefreshToken 삽입
      dio.options.headers['Authorization'] = 'Bearer $refreshToken';

      // 위의 Dio 객체를 이용해 RestClient 객체 생성
      final client = AuthApi(dio);

      try {
        // Access Token 재요청
        final response = await client.putNewAccessToken();

        // // Response에 Result가 없을 경우 에러
        // if (response.result == null) {
        //   return handler.reject(err);
        // }
        //
        // // 신규 토큰 저장
        // await secureStorage.write(
        //     key: ACCESS_TOKEN_STORAGE_KEY, value: response.result?.accessToken);
        // await secureStorage.write(
        //     key: REFRESH_TOKEN_STORAGE_KEY,
        //     value: response.result?.refreshToken);
        //
        // // 헤더에 엑세스 토큰 변경
        // err.requestOptions.headers['Authorization'] =
        //     'Bearer ${response.result?.accessToken}';

        // 다시 요청
        return handler.resolve(await dio.request(err.requestOptions.path,
            options: Options(
                method: err.requestOptions.method,
                headers: err.requestOptions.headers),
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters));
      }
      // 에러 발생시 Reject
      catch (error) {
        if (error is DioException) {
          logger.e(
              "[Network / [${error.requestOptions.method}] ${error.requestOptions.uri}] Issue New Token Error\n${error.message}",
              error: error.error,
              stackTrace: error.stackTrace);
        } else {
          logger.e("[Network] Issue New Token Error", error: error);
        }
        return handler.reject(err);
      }
    }

    logger.e(
        "[Network / [${err.requestOptions.method}] ${err.requestOptions.uri}] Request Error",
        error: err.error,
        stackTrace: err.stackTrace);
    return handler.reject(err);
  }
}
