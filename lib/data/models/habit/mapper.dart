import 'package:habitree/data/models/habit/habit_dto.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/shared/extensions/hex_color_extension.dart';
import 'package:habitree/shared/extensions/time_of_day_extensions.dart';

extension HabitDtoMapper on HabitDto {
  HabitEntity toEntity() {
    return HabitEntity(
      id: id,
      title: title,
      emoji: emoji,
      color: HexColor.fromHex(color),
      repeatDays: repeatDays.map((d) => Weekday.values.byName(d)).toList(),
      isDaily: isDaily,
      time: TimeOfDayExtensions.parse(timeOfDay),
      term: HabitTerm.values.byName(term),
      isOneTime: isOneTime,
      isArchived: isArchived,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension HabitEntityMapper on HabitEntity {
  HabitDto toDto({required String userId}) {
    return HabitDto(
      id: id,
      userId: userId,
      title: title,
      emoji: emoji,
      color: color.toHex(),
      repeatDays: repeatDays.map((d) => d.name).toList(),
      isDaily: isDaily,
      timeOfDay: time.formatString(),
      term: term.name,
      isOneTime: isOneTime,
      isArchived: isArchived,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
