import 'package:json_annotation/json_annotation.dart';

part 'post_email_send_request.g.dart';

@JsonSerializable()
class PostEmailSendRequest {
  String to;
  String subject;
  String message;

  PostEmailSendRequest({
    required this.to,
    required this.subject,
    required this.message,
  });

  factory PostEmailSendRequest.fromJson(Map<String, dynamic> json) =>
      _$PostEmailSendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostEmailSendRequestToJson(this);
}
