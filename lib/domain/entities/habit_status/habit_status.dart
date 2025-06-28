import 'package:flutter/material.dart';
import 'package:habitree/core/theme/app_colors.dart';

class HabitStatus {
  const HabitStatus({
    required this.id,
    required this.title,
    required this.emoji,
    required this.color,
    required this.time,
    required this.completed,
    required this.isDaily,
    required this.repeatDays,
    required this.term,
    required this.isOneTime,
  });

  final String id;
  final String title;
  final String emoji;
  final Color color;
  final TimeOfDay time;
  final bool completed;

  final bool isDaily;
  final List<String> repeatDays;
  final String term;
  final bool isOneTime;

  static List<HabitStatus> fakeList(int i) {
    return List.generate(
      i,
      (index) => HabitStatus(
        id: 'id_$index',
        title: 'Habit $index',
        emoji: '😊',
        color: AppColors.grayLight,
        time: TimeOfDay(hour: index % 24, minute: index % 60),
        completed: true,
        isDaily: index % 3 == 0,
        repeatDays: ['Monday', 'Wednesday', 'Friday'],
        term: '2023-01-01 to 2023-12-31',
        isOneTime: index % 5 == 0,
      ),
    );
  }
}
