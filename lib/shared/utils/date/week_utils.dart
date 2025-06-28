class WeekUtils {
  /// Returns a list of 7 dates representing the current week
  /// (starting from Monday to Sunday), including today.
  static List<DateTime> generateCurrentWeekDates() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));

    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  /// Checks whether the provided [date] is today.
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
