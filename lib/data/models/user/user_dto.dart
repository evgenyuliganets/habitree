import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  const UserDto({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    this.name,
    this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>;
    final meta = user['user_metadata'] as Map<String, dynamic>? ?? {};

    return UserDto(
      id: user['id'] as String,
      email: user['email'] as String,
      createdAt: DateTime.parse(user['created_at'] as String),
      updatedAt: DateTime.parse(user['updated_at'] as String),
      name: meta['name'] as String? ?? meta['full_name'] as String?,
      avatarUrl: meta['avatar_url'] as String? ?? meta['picture'] as String?,
    );
  }

  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
