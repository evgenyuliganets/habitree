import 'package:flutter/material.dart';
import 'package:habitree/data/models/habit_status/habit_status_dto.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';

extension HabitStatusDtoMapper on HabitStatusDto {
  HabitStatus toEntity() {
    final parts = timeOfDay.split(':');
    return HabitStatus(
      id: id,
      title: title,
      emoji: emoji,
      color: _parseColor(color),
      time: TimeOfDay(
        hour: int.parse(parts[0]),
        minute: int.parse(parts[1]),
      ),
      completed: completed,
      isDaily: isDaily,
      repeatDays: repeatDays,
      term: term,
      isOneTime: isOneTime,
    );
  }
}

extension HabitStatusEntityMapper on HabitStatus {
  HabitStatusDto toDto() {
    final timeFormatted = '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:00';

    return HabitStatusDto(
      id: id,
      title: title,
      emoji: emoji,
      color: '#${color.value.toRadixString(16).substring(2).toUpperCase()}',
      timeOfDay: timeFormatted,
      completed: completed,
      isDaily: isDaily,
      repeatDays: repeatDays,
      term: term,
      isOneTime: isOneTime,
    );
  }
}


Color _parseColor(String hexColor) {
  final hex = hexColor.replaceFirst('#', '');
  final value = int.parse(hex.length == 6 ? 'FF$hex' : hex, radix: 16);
  return Color(value);
}
