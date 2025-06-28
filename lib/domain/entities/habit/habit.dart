import 'package:flutter/material.dart';

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

enum HabitTerm {
  week,
  month,
  threeMonths,
  year,
  forever,
}

class HabitEntity {
  const HabitEntity({
    required this.id,
    required this.title,
    required this.emoji,
    required this.color,
    required this.repeatDays,
    required this.isDaily,
    required this.time,
    required this.term,
    required this.isOneTime,
    required this.isArchived,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String emoji;
  final Color color;

  final List<Weekday> repeatDays;
  final bool isDaily;
  final TimeOfDay time;

  final HabitTerm term;
  final bool isOneTime;

  final bool isArchived;
  final bool isDeleted;

  final DateTime createdAt;
  final DateTime updatedAt;
}
