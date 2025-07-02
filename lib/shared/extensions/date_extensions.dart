extension DateExtensions on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns a string in 'yyyy-MM-dd' format (without time part)
  /// ✅ Safe for SQL `date` columns
  String toDateOnlyIso() => toIso8601String().split('T').first;
}
