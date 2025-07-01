import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_habit.g.dart';

@JsonSerializable()
class CreateHabitDto {
  const CreateHabitDto({
    required this.title,
    required this.emoji,
    required this.color,
    required this.timeOfDay,
    required this.term,
    required this.repeatDays,
    required this.isDaily,
    required this.isOneTime,
  });

  factory CreateHabitDto.fromJson(Map<String, dynamic> json) =>
      _$CreateHabitDtoFromJson(json);

  final String title;
  final String emoji;
  final String color;

  @JsonKey(name: 'time_of_day')
  final String timeOfDay; // Still as 'HH:mm:ss'

  final String term;

  @JsonKey(name: 'repeat_days')
  final List<String> repeatDays;

  @JsonKey(name: 'is_daily')
  final bool isDaily;

  @JsonKey(name: 'is_one_time')
  final bool isOneTime;

  Map<String, dynamic> toJson() => _$CreateHabitDtoToJson(this);
}
