import 'package:habitree/data/models/user/user_dto.dart';
import 'package:habitree/domain/entities/user/user.dart';

extension UserMapper on UserDto {
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension UserDtoMapper on User {
  UserDto toDto() {
    return UserDto(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
