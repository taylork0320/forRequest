import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../utils/constants.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @PUT("/auth/token")
  Future<void> putNewAccessToken();
}
