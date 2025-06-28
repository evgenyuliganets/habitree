import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';

part 'habits_by_date_state.freezed.dart';

@freezed
class HabitsByDateState with _$HabitsByDateState {
  const HabitsByDateState._();

  const factory HabitsByDateState.initial() = _Initial;
  const factory HabitsByDateState.loading() = _Loading;
  const factory HabitsByDateState.loaded({
    required List<HabitStatus> habits,
    required int offset,
    required int total,
    required bool hasMore,
  }) = _Loaded;
  const factory HabitsByDateState.error(String message) = _Error;

  List<HabitStatus> get habitsOrEmpty => maybeWhen(
    loaded: (habits, _, __, ___) => habits,
    orElse: () => [],
  );
}

