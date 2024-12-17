import 'package:json_annotation/json_annotation.dart';

part 'post_login_response.g.dart';

@JsonSerializable()
class PostLoginResponse {
  PostLoginResponse({
    required this.grantType,
    required this.accessToken,
    required this.refreshToken,
  });

  String grantType;
  String accessToken;
  String refreshToken;

  factory PostLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$PostLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostLoginResponseToJson(this);
}
