import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/presentation/create_habbit/provider/habit_draft.dart';

final createHabitProvider =
    NotifierProvider.autoDispose<CreateHabitNotifier, HabitDraft>(
  CreateHabitNotifier.new,
);

class CreateHabitNotifier extends AutoDisposeNotifier<HabitDraft> {
  @override
  HabitDraft build() => const HabitDraft();

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setEmoji(String value) {
    state = state.copyWith(emoji: value);
  }

  void setColor(Color value) {
    state = state.copyWith(color: value);
  }

  void setRepeatDays(List<Weekday> days) {
    state = state.copyWith(repeatDays: days);
  }

  void toggleRepeatDay(Weekday day) {
    final updated = [...state.repeatDays];
    if (updated.contains(day)) {
      updated.remove(day);
    } else {
      updated.add(day);
    }
    state = state.copyWith(repeatDays: updated);
  }

  void setIsDaily({required bool value}) {
    state = state.copyWith(isDaily: value);
  }

  void setIsOneTime({required bool value}) {
    state = state.copyWith(isOneTime: value);
  }

  void setTime(TimeOfDay value) {
    state = state.copyWith(time: value);
  }

  void setTerm(HabitTerm value) {
    state = state.copyWith(term: value);
  }

  Future<void> submit(String userId) async {
    final dto = state.toDto(userId);
    // await ref.read(habitRepositoryProvider).createHabit(dto);
  }
}
