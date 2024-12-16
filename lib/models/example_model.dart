import 'package:json_annotation/json_annotation.dart';

part 'example_model.g.dart';

@JsonSerializable()
class ErrorMessageInfo {
  @JsonKey(name: "ERRURL")
  final String errUrl;
  @JsonKey(name: "ERRMSG")
  final String errMessage;
  @JsonKey(name: "STATUSCODE")
  final int statusCode;

  ErrorMessageInfo(this.errUrl, this.errMessage, this.statusCode);

  Map<String, dynamic> toJson() => _$ErrorMessageInfoToJson(this);
  factory ErrorMessageInfo.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageInfoFromJson(json);
}