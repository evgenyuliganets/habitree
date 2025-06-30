import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habitree/core/result/result.dart';
import 'package:habitree/di/di.dart';
import 'package:habitree/domain/entities/habit_status/habit_status.dart';
import 'package:habitree/domain/usecases/habits/get_habits_status_usecase.dart';
import 'package:habitree/presentation/home/habits_ui/provider/habits_by_date_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HabitsByDateNotifier extends StateNotifier<HabitsByDateState> {
  HabitsByDateNotifier(this._getHabitsUseCase)
      : super(const HabitsByDateState.initial());

  final GetUserHabitsByDateUseCase _getHabitsUseCase;

  static const int _limit = 10;

  DateTime _currentDate = DateTime.now();
  bool _isLoadingNext = false;

  Future<void> loadInitial(DateTime date) async {
    _currentDate = date;
    state = const HabitsByDateState.loading();

    final result = await _getHabitsUseCase(
      GetHabitsByDateParam(
        date: date,
        limit: _limit,
        offset: 0,
      ),
    );

    result.mapResult(
      success: (paginated) {
        state = HabitsByDateState.loaded(
          habits: paginated.items,
          offset: 0,
          total: paginated.totalCount,
          hasMore: paginated.items.length == _limit,
        );
      },
      failure: (f) {
        log(
          '❌ Failed to load habits for date ${date.toIso8601String()}: ${f}',
          name: 'HabitsByDateNotifier',
        );
        state = HabitsByDateState.error(f.userMessage);
      },
    );
  }

  Future<void> loadNextPage() async {
    final loaded = state.whenOrNull(
      loaded: (habits, offset, total, hasMore) => (habits, offset, hasMore),
    );

    if (loaded == null) return;

    final (currentHabits, currentOffset, hasMore) = loaded;

    if (!hasMore || _isLoadingNext) return;
    _isLoadingNext = true;

    final result = await _getHabitsUseCase(
      GetHabitsByDateParam(
        date: _currentDate,
        offset: currentOffset + _limit,
        limit: _limit,
      ),
    );

    result.mapResult(
      success: (paginated) {
        state = HabitsByDateState.loaded(
          habits: [...currentHabits, ...paginated.items],
          offset: currentOffset + _limit,
          total: paginated.totalCount,
          hasMore: paginated.items.length == _limit,
        );
      },
      failure: (f) {
        log(
          '❌ Failed to load next habits: ${f.userMessage}',
          name: 'HabitsByDateNotifier',
        );
      },
    );

    _isLoadingNext = false;
  }

  void toggleHabit(HabitStatus habit, DateTime selectedDate) {
    var currentHabits = <HabitStatus>[];
    var offset = 0;
    var hasMore = false;

    state.maybeWhen(
      loaded: (habits, off, tot, more) {
        currentHabits = habits;
        offset = off;
        // total = tot;
        hasMore = more;
      },
      orElse: () {
        log('❌ Cannot toggle habit when state is not loaded');
        return;
      },
    );

    final updatedHabits = currentHabits.map((h) {
      if (h.id == habit.id) {
        return h.copyWith(
          isCompleted: !h.completed,
          lastUpdated: DateTime.now(),
        );
      }
      return h;
    }).toList();

    state = HabitsByDateState.loaded(
      habits: updatedHabits,
      offset: offset,
      total: updatedHabits.length,
      hasMore: hasMore,
    );
  }
}

final habitsByDateProvider =
    StateNotifierProvider.autoDispose<HabitsByDateNotifier, HabitsByDateState>(
  (ref) => getIt<HabitsByDateNotifier>(),
);
