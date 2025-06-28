import 'package:json_annotation/json_annotation.dart';

part 'habit_status_dto.g.dart';

@JsonSerializable()
class HabitStatusDto {
  const HabitStatusDto({
    required this.id,
    required this.title,
    required this.emoji,
    required this.color,
    required this.timeOfDay,
    required this.completed,
    required this.isDaily,
    required this.repeatDays,
    required this.term,
    required this.isOneTime,
  });

  factory HabitStatusDto.fromJson(Map<String, dynamic> json) =>
      _$HabitStatusDtoFromJson(json);

  final String id;
  final String title;
  final String emoji;
  final String color;

  @JsonKey(name: 'time_of_day')
  final String timeOfDay;

  final bool completed;

  @JsonKey(name: 'is_daily')
  final bool isDaily;

  @JsonKey(name: 'repeat_days')
  final List<String> repeatDays;

  final String term;

  @JsonKey(name: 'is_one_time')
  final bool isOneTime;

  Map<String, dynamic> toJson() => _$HabitStatusDtoToJson(this);
}
