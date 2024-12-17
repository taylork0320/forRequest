import 'package:json_annotation/json_annotation.dart';
import 'package:sasimee/models/user_tag.dart';

part 'post_register_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PostRegisterRequest {
  String email;
  String password1;
  String password2;
  String name;
  String phoneNumber;
  List<UserTag> tags;

  PostRegisterRequest({
    required this.email,
    required this.password1,
    required this.password2,
    required this.name,
    required this.phoneNumber,
    required this.tags,
  });

  factory PostRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$PostRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostRegisterRequestToJson(this);
}
