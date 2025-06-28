import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/presentation/home/week_day/provider/week_state.dart';
import 'package:habitree/shared/utils/date/week_utils.dart';

class WeekNotifier extends Notifier<WeekState> {
  @override
  WeekState build() {
    final week = WeekUtils.generateCurrentWeekDates();
    final selectedIndex = week.indexWhere(WeekUtils.isToday);
    return WeekState(weekDates: week, selectedIndex: selectedIndex);
  }

  void selectIndex(int index) {
    state = state.copyWith(selectedIndex: index);
  }

  void selectDate(DateTime date) {
    final index = state.weekDates.indexWhere(
      (d) => d.year == date.year && d.month == date.month && d.day == date.day,
    );
    if (index != -1) {
      selectIndex(index);
    }
  }
}

final weekProvider = NotifierProvider<WeekNotifier, WeekState>(
  WeekNotifier.new,
);
