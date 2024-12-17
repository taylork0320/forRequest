import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

typedef FrProfile = ProfileResponse;

@JsonSerializable()
class ProfileResponse {
  String email;
  String name;
  String phonenumber;

  ProfileResponse({
    required this.email,
    required this.name,
    required this.phonenumber,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
