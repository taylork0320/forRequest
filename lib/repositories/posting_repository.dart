import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sasimee/models/response/post/get_posting_list_response.dart';
import 'package:sasimee/services/api/posting_api.dart';

import '../services/network/dio_service.dart';
import '../utils/logger.dart';

class PostingRepository {
  final _api = PostingApi(DioService().get());
  final Logger logger = LoggerUtils().get();

  /// 완수한 게시글 조회
  Future<GetPostingListResponse?> getCompletePostingList() async {
    try {
      var response = await _api.getCompletePostingList();
      return response;
    } catch (e) {
      logger.e("Failed to get complete posting list.", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }

  /// 현재 로그인한 유저가 작성한 게시글 조회
  Future<GetPostingListResponse?> getUserPostingList() async {
    try {
      var response = await _api.getUserPostingList();
      return response;
    } catch (e) {
      logger.e("Failed to get user posting list.", error: e);

      if (e is DioException && e.response != null) {
        return null;
      }

      return null;
    }
  }
}
