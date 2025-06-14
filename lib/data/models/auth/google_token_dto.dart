import 'package:habitree/domain/entities/auth/google_token.dart';
import 'package:json_annotation/json_annotation.dart';

part 'google_token_dto.g.dart';

@JsonSerializable()
class GoogleTokenDto {
  const GoogleTokenDto({
    required this.accessToken,
    required this.idToken,
    this.provider = 'google',
  });

  factory GoogleTokenDto.fromDomain(GoogleToken token) => GoogleTokenDto(
    accessToken: token.accessToken,
    idToken: token.idToken,
  );

  factory GoogleTokenDto.fromJson(Map<String, dynamic> json) =>
      _$GoogleTokenDtoFromJson(json);

  final String accessToken;

  @JsonKey(name: 'id_token')
  final String idToken;

  @JsonKey(includeIfNull: false)
  final String provider;

  GoogleToken toDomain() => GoogleToken(
    accessToken: accessToken,
    idToken: idToken,
  );

  Map<String, dynamic> toJson() => _$GoogleTokenDtoToJson(this);
}
