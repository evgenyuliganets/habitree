import 'package:habitree/domain/entities/auth/session.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_dto.g.dart';

@JsonSerializable()
class SessionDto {
  const SessionDto({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  factory SessionDto.fromDomain(Session session) => SessionDto(
    accessToken: session.accessToken,
    refreshToken: session.refreshToken,
    expiresAt: session.expiresAt,
  );

  factory SessionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionDtoFromJson(json);

  @JsonKey(name: 'access_token')
  final String accessToken;

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  @JsonKey(
    name: 'expires_at',
    fromJson: _fromUnix,
    toJson: _toUnix,
  )
  final DateTime expiresAt;

  Map<String, dynamic> toJson() => _$SessionDtoToJson(this);

  Session toDomain() => Session(
    accessToken: accessToken,
    refreshToken: refreshToken,
    expiresAt: expiresAt,
  );

  static DateTime _fromUnix(int ts) =>
      DateTime.fromMillisecondsSinceEpoch(ts * 1000);

  static int _toUnix(DateTime dt) =>
      dt.millisecondsSinceEpoch ~/ 1000;
}
