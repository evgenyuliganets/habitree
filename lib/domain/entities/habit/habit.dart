import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:intl/intl.dart';

List<Weekday> weekDaysFromJson(List<String> json) {
  return json
      .map((e) => Weekday.values.firstWhere((d) => d.name == e))
      .toList();
}

List<String> weekDaysToJson(List<Weekday> days) {
  return days.map((e) => e.name).toList();
}

enum Weekday {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String getLabel(Locale locale) {
    final date = DateTime(2024, 7, _dayNumber);
    final formatter = DateFormat.E(locale.toString());

    return toBeginningOfSentenceCase(formatter.format(date))!;
  }

  int get _dayNumber {
    switch (this) {
      case Weekday.monday:
        return 1;
      case Weekday.tuesday:
        return 2;
      case Weekday.wednesday:
        return 3;
      case Weekday.thursday:
        return 4;
      case Weekday.friday:
        return 5;
      case Weekday.saturday:
        return 6;
      case Weekday.sunday:
        return 7;
    }
  }

  String getFullLabel(Locale locale) {
    final baseDate = DateTime(2024, 7);
    final date = baseDate.add(Duration(days: index));
    return toBeginningOfSentenceCase(
      DateFormat.EEEE(locale.toString()).format(date),
    )!;
  }
}

enum HabitTerm {
  week,
  month,
  threeMonths,
  year,
  forever;

  String title(Translations locale) {
    switch (this) {
      case HabitTerm.week:
        return locale.habitCreationFilling.termWeek;
      case HabitTerm.month:
        return locale.habitCreationFilling.termMonth;
      case HabitTerm.threeMonths:
        return locale.habitCreationFilling.term3Months;
      case HabitTerm.year:
        return locale.habitCreationFilling.termYear;
      case HabitTerm.forever:
        return locale.habitCreationFilling.termForever;
    }
  }
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
