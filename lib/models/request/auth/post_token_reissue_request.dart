import 'package:json_annotation/json_annotation.dart';

part 'post_token_reissue_request.g.dart';

@JsonSerializable()
class PostTokenReissueRequest {
  String? accessToken;
  String refreshToken;

  PostTokenReissueRequest({
    required this.accessToken,
    required this.refreshToken
  });

  factory PostTokenReissueRequest.fromJson(Map<String, dynamic> json) => _$PostTokenReissueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostTokenReissueRequestToJson(this);
}