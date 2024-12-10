import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sasimee/services/network/token_interceptor.dart';

import '../../utils/logger.dart';

class DioService {
  final Logger logger = LoggerUtils().get();
  static final DioService _instance = DioService._internal();
  factory DioService() => _instance;
  late Dio _dio;

  DioService._internal() {
    var dioBaseOption =
        BaseOptions(baseUrl: const String.fromEnvironment("API_URL"));
    _dio = Dio(dioBaseOption);

    // Token Interceptor 추가
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(LogInterceptor(
        request: false,
        requestBody: true,
        requestHeader: false,
        responseBody: true,
        responseHeader: false,
        logPrint: (logObject) {
          log(logObject.toString());
        }));
  }

  Dio get() => _dio;
}
