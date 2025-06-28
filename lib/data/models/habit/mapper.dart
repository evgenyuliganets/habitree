import 'package:flutter/material.dart';
import 'package:habitree/data/models/habit/habit_dto.dart';
import 'package:habitree/domain/entities/habit/habit.dart';

extension HabitDtoMapper on HabitDto {
  HabitEntity toEntity() {
    final timeParts = timeOfDay.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return HabitEntity(
      id: id,
      title: title,
      emoji: emoji,
      color: Color(int.parse(color)),
      repeatDays: repeatDays.map((d) => Weekday.values.byName(d)).toList(),
      isDaily: isDaily,
      time: TimeOfDay(hour: hour, minute: minute),
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
      color: color.value.toString(),
      repeatDays: repeatDays.map((d) => d.name).toList(),
      isDaily: isDaily,
      timeOfDay: '${time.hour.toString().padLeft(2, '0')}'
          ':${time.minute.toString().padLeft(2, '0')}',
      term: term.name,
      isOneTime: isOneTime,
      isArchived: isArchived,
      isDeleted: isDeleted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
