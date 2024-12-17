import 'package:json_annotation/json_annotation.dart';

part 'post_email_send_response.g.dart';

@JsonSerializable()
class PostEmailSendResponse {
  bool status;
  String message;
  String receiver;

  PostEmailSendResponse({
    required this.status,
    required this.message,
    required this.receiver,
  });

  factory PostEmailSendResponse.fromJson(Map<String, dynamic> json) =>
      _$PostEmailSendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostEmailSendResponseToJson(this);
}
