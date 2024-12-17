import 'package:json_annotation/json_annotation.dart';

part 'get_profile_response.g.dart';

typedef FrProfile = GetProfileResponse;

@JsonSerializable()
class GetProfileResponse {
  String email;
  String name;
  String phonenumber;

  GetProfileResponse({
    required this.email,
    required this.name,
    required this.phonenumber,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileResponseToJson(this);
}
