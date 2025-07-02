import 'package:habitree/core/result/result.dart';
import 'package:habitree/core/usecases/base_usecase.dart';
import 'package:habitree/domain/repositories/habits/habits_repository.dart';
import 'package:habitree/shared/extensions/date_extensions.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToggleHabitDoneUseCase extends BaseUseCase<ToggleHabitParam, Result<bool>> {
  ToggleHabitDoneUseCase(
    this._habitsRepository,
  );

  final HabitsRepository _habitsRepository;

  @override
  Future<Result<bool>> execute(ToggleHabitParam param) async {
    return _habitsRepository.toggleHabit(param: param);
  }
}

class ToggleHabitParam {
  ToggleHabitParam({
    required this.habitId,
    required this.date,
    required this.completed,
  });

  final String habitId;
  final DateTime date;
  final bool completed;

  Map<String, dynamic> toJson() {
    return {
      'habit_id': habitId,
      'date': date.toDateOnlyIso(),
      'completed': completed,
    };
  }
}
