import 'package:json_annotation/json_annotation.dart';

part 'habit_dto.g.dart';

@JsonSerializable()
class HabitDto {
  const HabitDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.emoji,
    required this.color,
    required this.repeatDays,
    required this.isDaily,
    required this.timeOfDay,
    required this.term,
    required this.isOneTime,
    required this.isArchived,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HabitDto.fromJson(Map<String, dynamic> json) =>
      _$HabitDtoFromJson(json);
  final String id;
  @JsonKey(name: 'user_id')
  final String userId;

  final String title;
  final String emoji;
  final String color;

  @JsonKey(name: 'repeat_days')
  final List<String> repeatDays;

  @JsonKey(name: 'is_daily')
  final bool isDaily;

  @JsonKey(name: 'time_of_day')
  final String timeOfDay; // Format HH:mm:ss

  final String term;

  @JsonKey(name: 'is_one_time')
  final bool isOneTime;

  @JsonKey(name: 'is_archived')
  final bool isArchived;

  @JsonKey(name: 'is_deleted')
  final bool isDeleted;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  Map<String, dynamic> toJson() => _$HabitDtoToJson(this);
}
