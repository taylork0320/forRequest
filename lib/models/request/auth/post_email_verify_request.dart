import 'package:json_annotation/json_annotation.dart';

part 'post_email_verify_request.g.dart';

@JsonSerializable()
class PostEmailVerifyRequest {
  String email;
  String authNum;

  PostEmailVerifyRequest({
    required this.email,
    required this.authNum,
  });

  factory PostEmailVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$PostEmailVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostEmailVerifyRequestToJson(this);
}
