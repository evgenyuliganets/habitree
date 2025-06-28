import 'package:freezed_annotation/freezed_annotation.dart';

part 'week_state.freezed.dart';

@freezed
class WeekState with _$WeekState {
  // allows custom getters

  const factory WeekState({
    required List<DateTime> weekDates,
    required int selectedIndex,
  }) = _WeekState;

  const WeekState._();

  DateTime get selectedDate => weekDates[selectedIndex];
}
