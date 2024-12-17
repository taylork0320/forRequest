import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sasimee/models/response/auth/post_login_response.dart';

import '../../models/request/auth/post_login_request.dart';
import '../../models/request/auth/post_token_reissue_request.dart';
import '../../utils/constants.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  // 로그인
  @POST("/user/login")
  Future<PostLoginResponse> postLogin(
      @Body() PostLoginRequest postLoginRequest);

  // 토큰 재발급
  @POST("/user/reissue")
  Future<PostLoginResponse> postTokenReissue(
      @Body() PostTokenReissueRequest postTokenReissueRequest);
}
