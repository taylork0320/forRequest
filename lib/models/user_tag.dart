import 'package:json_annotation/json_annotation.dart';

part 'user_tag.g.dart';

@JsonSerializable()
class UserTag {
  String name;
  String category;

  UserTag({required this.name, required this.category});

  factory UserTag.fromJson(Map<String, dynamic> json) =>
      _$UserTagFromJson(json);

  Map<String, dynamic> toJson() => _$UserTagToJson(this);
}
