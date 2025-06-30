import 'package:flutter/material.dart';

extension TimeOfDayExtensions on TimeOfDay {
 static TimeOfDay parse(String time) {
    final parts = time.split(':');
    if (parts.length != 2) {
      throw FormatException('Invalid time format: $time');
    }
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  String formatString() {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
