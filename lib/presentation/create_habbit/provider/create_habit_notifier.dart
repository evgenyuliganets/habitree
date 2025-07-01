import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/theme/export_ui_styleguide.dart';
import 'package:habitree/di/di.dart';
import 'package:habitree/domain/entities/habit/habit.dart';
import 'package:habitree/domain/usecases/habits/create_habit_usecase.dart';
import 'package:habitree/presentation/create_habbit/provider/habit_draft.dart';
import 'package:habitree/shared/utils/navigation/navigation_service.dart';
import 'package:injectable/injectable.dart';

final createHabitProvider =
    NotifierProvider.autoDispose<CreateHabitNotifier, HabitDraft>(getIt.call);

@injectable
class CreateHabitNotifier extends AutoDisposeNotifier<HabitDraft> {
  CreateHabitNotifier(this._createHabitUseCase) : super();

  final CreateHabitUseCase _createHabitUseCase;

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

  void toggleDay({required Weekday day, required bool value}) {
    final currentDays = state.repeatDays.toSet();
    if (value) {
      currentDays.add(day);
    } else {
      currentDays.remove(day);
    }
    state = state.copyWith(
      repeatDays: currentDays.toList(),
      isDaily: currentDays.length == Weekday.values.length,
    );
  }

  void setIsDaily({required bool value}) {
    state =
        state.copyWith(isDaily: value, repeatDays: value ? Weekday.values : []);
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

  Future<void> submit(String title) async {
    final dto = state.copyWith(title: title).toDto();
    final result = await _createHabitUseCase(dto);
    result.mapResult(
      success: (isCreated) {
        final context = NavigationService.navigatorKey.currentContext;
        if(context != null) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      failure: (failure) {
        // Handle failure case, e.g., show an error message
        throw Exception(failure.userMessage);
      },
    );
  }
}
