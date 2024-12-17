import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:sasimee/models/response/post/get_posting_list_response.dart';

import '../../utils/constants.dart';

part 'posting_api.g.dart';

@RestApi(baseUrl: BASE_URL)
abstract class PostingApi {
  factory PostingApi(Dio dio, {String baseUrl}) = _PostingApi;

  // 완수한 게시글 조회
  @GET("/clear/get")
  Future<GetPostingListResponse> getCompletePostingList();

  // 현재 로그인한 유저가 작성한 게시글 조회
  @GET("/post/get/user")
  Future<GetPostingListResponse> getUserPostingList();
}
