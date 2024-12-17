import 'package:json_annotation/json_annotation.dart';
import 'package:sasimee/models/posting.dart';

part 'get_posting_list_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetPostingListResponse {
  List<Posting> posts;
  int currentPage;
  int totalPage;
  int totalElements;

  GetPostingListResponse({
    required this.posts,
    required this.currentPage,
    required this.totalPage,
    required this.totalElements,
  });

  factory GetPostingListResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPostingListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostingListResponseToJson(this);
}
