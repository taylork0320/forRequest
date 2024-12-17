import 'package:json_annotation/json_annotation.dart';

part 'post_login_request.g.dart';

@JsonSerializable()
class PostLoginRequest {
  String email;
  String password;

  PostLoginRequest({
    required this.email,
    required this.password
  });

  factory PostLoginRequest.fromJson(Map<String, dynamic> json) => _$PostLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostLoginRequestToJson(this);
}