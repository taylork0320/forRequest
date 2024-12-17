import 'package:json_annotation/json_annotation.dart';

part 'post_profile_request.g.dart';

@JsonSerializable()
class PostProfileRequest {
  String name;
  String phonenumber;

  PostProfileRequest({
    required this.name,
    required this.phonenumber
  });

  factory PostProfileRequest.fromJson(Map<String, dynamic> json) => _$PostProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostProfileRequestToJson(this);
}